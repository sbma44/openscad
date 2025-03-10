use <threads.scad>;

TPU_WALL_THICKNESS = 1;
OUTER_DIAM = 40.25;
INNER_DIAM = 28;
DISC_A_Z = 5.9 - TPU_WALL_THICKNESS;
DISC_B_Z = 4 - TPU_WALL_THICKNESS;
TOTAL_Z = 19.7;
CHANNEL_Z = TOTAL_Z - (DISC_A_Z + DISC_B_Z);
CONE_DIAM = 1.0 * OUTER_DIAM;
CONE_EXTENSION_Z = 0.5 * DISC_B_Z;

BEARING_DIAM_FUDGE = 0.25;
BEARING_DIAM = 22 + BEARING_DIAM_FUDGE;
BEARING_INNER_DIAM = 13; // have to clear the inner ring of metal
BEARING_Z = 7;
SNAP_SPHINCTER_FUDGE = 2;
THREAD_EXTENSION = 0.5;
THREAD_SCALE = 1.035;

SHELL_Z = DISC_A_Z - TPU_WALL_THICKNESS;

CENTER_CHANNEL_THICKNESS = 1;
CENTER_CHANNEL_AXIS_DIAM = BEARING_DIAM + (2 * CENTER_CHANNEL_THICKNESS);

TAB_EXTENSION = 1.25;
TAB_HEIGHT = 1;

inch_in_cm = 2.54;
inch_in_mm = inch_in_cm * 10;
dpi = 300;
SCALE_FACTOR = inch_in_mm / dpi;

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
            cylinder(d=CENTER_CHANNEL_AXIS_DIAM, h=TOTAL_Z - 1, $fn=128);

            // cone
            translate([0, 0, CHANNEL_Z + DISC_A_Z + TPU_WALL_THICKNESS]) union () {
                cylinder(d1=CENTER_CHANNEL_AXIS_DIAM, d2=OUTER_DIAM, h=(DISC_B_Z + CONE_EXTENSION_Z) - TPU_WALL_THICKNESS, $fn=64);
                // supplemental ring
                translate([0, 0, (DISC_B_Z + CONE_EXTENSION_Z) - TPU_WALL_THICKNESS]) difference() {
                    cylinder(d=OUTER_DIAM, h=TPU_WALL_THICKNESS, $fn=64);
                    cylinder(d=BEARING_DIAM + (2 * TPU_WALL_THICKNESS), h=2 * TPU_WALL_THICKNESS, $fn=64);
                }
            }
            
            thread();
        }
        translate([0, 0, -1]) cylinder(d=BEARING_INNER_DIAM, h=TOTAL_Z, $fn=64);
        translate([0, 0, TOTAL_Z - BEARING_Z]) bearing();
        #translate([0, 0, TOTAL_Z - BEARING_Z + CONE_EXTENSION_Z + TPU_WALL_THICKNESS]) bearing();
        translate([0, 0, -1]) bearing();
    }
}

module hard_shell_b() {
    union () {
        difference() {

            cylinder(d=OUTER_DIAM, h=SHELL_Z, $fn=128);
            bearing();
            OUTER_DEPRESSION_Z = TAB_HEIGHT + 1;
            scale([THREAD_SCALE, THREAD_SCALE, 1]) thread();
        }
        SCALE_FACTOR = 0.235;
        rotate([180, 0, 0]) translate([3.25, 3, 0]) scale([SCALE_FACTOR, SCALE_FACTOR, 1]) linear_extrude(1) import("tomlee2.svg", center=true);
        
        translate([0, 0, -1]) difference() {
            cylinder(d=OUTER_DIAM, h=1, $fn=128);
            cylinder(d=OUTER_DIAM - 2, h=1, $fn=128);
        }
        translate([0, 0, -1]) difference() {
            cylinder(d=INNER_DIAM, h=1, $fn=128);
            cylinder(d=INNER_DIAM - 2, h=1, $fn=128);
        }
    }
}

module tpu_lining() {
    // wings of 1mm, core as thick as possible less 1mm of PETG in the middle
    difference() {
        union() {
            cylinder(d=INNER_DIAM, h=CHANNEL_Z + (2 * TPU_WALL_THICKNESS), $fn=128);
            cylinder(d = OUTER_DIAM, h=TPU_WALL_THICKNESS, $fn=128);

            // cone
            union () {
                translate([0, 0, CHANNEL_Z]) cylinder(d1=CENTER_CHANNEL_AXIS_DIAM, d2=OUTER_DIAM, h=(DISC_B_Z + CONE_EXTENSION_Z) - TPU_WALL_THICKNESS, $fn=64);
                translate([0, 0, CHANNEL_Z + (DISC_B_Z + CONE_EXTENSION_Z) - TPU_WALL_THICKNESS]) cylinder(d=OUTER_DIAM, h=TPU_WALL_THICKNESS, $fn=64);
            }
        }
        cylinder(d=BEARING_DIAM + (2 * CENTER_CHANNEL_THICKNESS), h=TOTAL_Z, $fn=128);

        // cone inner
        #translate([0, 0, CHANNEL_Z + TPU_WALL_THICKNESS]) cylinder(d1=CENTER_CHANNEL_AXIS_DIAM, d2=OUTER_DIAM, h=(DISC_B_Z + CONE_EXTENSION_Z) - TPU_WALL_THICKNESS, $fn=64);
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