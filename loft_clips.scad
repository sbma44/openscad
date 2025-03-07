MM_PER_INCH = 25.4;
CLEARANCE_Z = 3;
SCREW_DIAM = 3;
SCREW_HEAD_DIAM = 7;
SCREW_HEAD_Z = 2;
THICKNESS = 2;
BRACKET_X = 1.5 * MM_PER_INCH;
BRACKET_Y = 0.5 * MM_PER_INCH;
FUDGE = 0.5;

BIG_CYL_DIAM = 550;

module clip() {
    intersection() {
        difference() {
            union() {
                cylinder(d=SCREW_DIAM + (2 * THICKNESS) + FUDGE, h=CLEARANCE_Z, $fn=64);
                translate([0, 0, -0.5 * THICKNESS]) cube([BRACKET_X, BRACKET_Y, THICKNESS], center=true);
            }
            translate([0, 0, -1 * THICKNESS]) union() {
                cylinder(d=SCREW_DIAM + FUDGE, h=CLEARANCE_Z + THICKNESS, $fn=64);
                cylinder(d1=SCREW_HEAD_DIAM, d2=SCREW_DIAM, h=SCREW_HEAD_Z, $fn=64);
            }
        }
        translate([0, 0.5 * BRACKET_Y, (0.5 * BIG_CYL_DIAM) - THICKNESS]) rotate([90, 0, 0]) cylinder(d=BIG_CYL_DIAM, h=BRACKET_Y, $fn=128);
    }
}

// edge clip
intersection() {
    clip();
    union() {
        translate([0, 0, -1 * THICKNESS]) cylinder(d=BRACKET_Y, h=CLEARANCE_Z + THICKNESS, $fn=64);
        translate([0, -0.5 * BRACKET_Y, -1 * THICKNESS]) cube([0.5 * BRACKET_X, BRACKET_Y, CLEARANCE_Z + THICKNESS]);
    }
}

// middle clip
translate([0, 2 * BRACKET_Y, 0]) clip();