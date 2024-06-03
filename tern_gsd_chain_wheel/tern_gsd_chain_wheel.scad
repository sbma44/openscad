use <threads.scad>;

TPU_WALL_THICKNESS = 1;
OUTER_DIAM = 40.25;
INNER_DIAM = 28;
DISC_A_Z = 5.9 - TPU_WALL_THICKNESS;
DISC_B_Z = 4 - TPU_WALL_THICKNESS;
TOTAL_Z = 19.7;
CHANNEL_Z = TOTAL_Z - (DISC_A_Z + DISC_B_Z);

BEARING_DIAM_FUDGE = 0.5;
BEARING_DIAM = 22 + BEARING_DIAM_FUDGE;
BEARING_INNER_DIAM = 9; // prob need to make this larger to ensure the bearing carries the shaft, not the plastic
BEARING_Z = 7;
SNAP_SPHINCTER_FUDGE = 2;
THREAD_EXTENSION = 0.5;
THREAD_SCALE = 1.035;

SHELL_Z = DISC_A_Z - TPU_WALL_THICKNESS;

CENTER_CHANNEL_THICKNESS = 1;

TAB_EXTENSION = 1.25;
TAB_HEIGHT = 1;

module bearing(fudge=0) {
    cylinder(d=BEARING_DIAM, h=BEARING_Z, $fn=128);
}

module model() {
    difference() {
        cylinder(d=OUTER_DIAM, h=TOTAL_Z, $fn=128);
        translate([0, 0, DISC_A_Z]) difference() {
            INSET_Z = TOTAL_Z - (DISC_A_Z + DISC_B_Z);
            cylinder(d=OUTER_DIAM, h=INSET_Z, $fn=128);
            cylinder(d=INNER_DIAM, h=INSET_Z, $fn=128);
        }
        bearing();
        translate([0, 0, TOTAL_Z - BEARING_Z]) bearing();
        cylinder(d=BEARING_INNER_DIAM, h=TOTAL_Z, $fn=64);
    }
}

//translate([OUTER_DIAM + 10, 0, 0]) model();

module thread() {
    metric_thread(diameter=BEARING_DIAM + (2 * CENTER_CHANNEL_THICKNESS) + (2 * THREAD_EXTENSION), length=SHELL_Z, internal=false);
}

module hard_shell_a() {
    
    translate([0, 0, 1]) difference() {
        union() {
            cylinder(d=BEARING_DIAM + (2 * CENTER_CHANNEL_THICKNESS), h=TOTAL_Z - 1, $fn=128);
            translate([0, 0, CHANNEL_Z + DISC_A_Z + TPU_WALL_THICKNESS]) cylinder(d=OUTER_DIAM, h=DISC_B_Z - TPU_WALL_THICKNESS, $fn=64);
            thread();
        }
        translate([0, 0, -1]) cylinder(d=BEARING_INNER_DIAM, h=TOTAL_Z, $fn=64);
        translate([0, 0, TOTAL_Z - BEARING_Z]) bearing();
        translate([0, 0, -1]) bearing();
    }
}

module hard_shell_b() {
    difference() {

        cylinder(d=OUTER_DIAM, h=SHELL_Z, $fn=128);
        bearing();
        OUTER_DEPRESSION_Z = TAB_HEIGHT + 1;
        scale([THREAD_SCALE, THREAD_SCALE, 1]) thread();
    }
}

module tpu_lining() {
    // wings of 1mm, core as thick as possible less 1mm of PETG in the middle
    difference() {
        union() {
            cylinder(d=INNER_DIAM, h=CHANNEL_Z + (2 * TPU_WALL_THICKNESS), $fn=128);
            cylinder(d = OUTER_DIAM, h=TPU_WALL_THICKNESS, $fn=128);
            translate([0, 0, (CHANNEL_Z + TPU_WALL_THICKNESS)]) cylinder(d = OUTER_DIAM, h=TPU_WALL_THICKNESS, $fn=128);
        }
        cylinder(d=BEARING_DIAM + (2 * CENTER_CHANNEL_THICKNESS), h=TOTAL_Z, $fn=128);
    }
}

if ((EXPORT==undef) || (EXPORT=="shell_a")) {
    hard_shell_a();
}
if ((EXPORT==undef) || (EXPORT=="shell_b")) {
    translate([0, 0, -7]) hard_shell_b();
}
if ((EXPORT==undef) || (EXPORT=="tpu_lining")) {
    translate([-1 * (OUTER_DIAM + 10), 0, 0]) tpu_lining();
}