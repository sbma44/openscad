MM_PER_INCH = 25.4;
CLEARANCE_Z = 3;
SCREW_DIAM = 4;
SCREW_HEAD_DIAM = 9.5;
SCREW_HEAD_Z = 3.5;

TACK_SCREW_HEAD_DIAM = 8;
TACK_SCREW_DIAM = 3;
TACK_SCREW_HEAD_Z = 3;

CYLINDER_THICKNESS = 4;
TAB_THICKNESS = 2;
BRACKET_X = 1.5 * MM_PER_INCH;
BRACKET_Y = 0.5 * MM_PER_INCH;
FUDGE = 0.5;

IBEAM_X = BRACKET_X;
IBEAM_Y = 3 * BRACKET_X;
IBEAM_THICKNESS_Z = 2;

EDGE_CYL_DIAM = 4;

BIG_CYL_DIAM = 550;

module rounded_cube(x, y, z, diam) {
    translate([0.5 * x, 0.5 * y, 0]) hull() for(bx=[-1:2:1]) {
        for(by=[-1:2:1]) {
            translate([bx * (0.5 * (x - diam)), by * (0.5 * (y - diam)), 0]) cylinder(h=z, d=diam, $fn=64);
        }
    }
}

module ibeam_holes() {
    translate([0, 0.2 * IBEAM_Y, 0]) {
            union() {
                cylinder(d=SCREW_DIAM + FUDGE, h=(2 * IBEAM_THICKNESS_Z) + CLEARANCE_Z, $fn=64);
                cylinder(d1=SCREW_HEAD_DIAM, d2=SCREW_DIAM, h=IBEAM_THICKNESS_Z, $fn=64);
            }
        }
        translate([0, 0.8 * IBEAM_Y, 0]) {
            union() {
                cylinder(d=SCREW_DIAM + FUDGE, h=(2 * IBEAM_THICKNESS_Z) + CLEARANCE_Z, $fn=64);
                cylinder(d1=TACK_SCREW_HEAD_DIAM, d2=TACK_SCREW_DIAM, h=TACK_SCREW_HEAD_Z, $fn=64);
            }
        }
}

module ibeam(TOP) {
    difference() {
        translate([-0.5 * IBEAM_X, 0, 0])  union() {
            if (TOP == 1) {
                rounded_cube(IBEAM_X, IBEAM_Y, IBEAM_THICKNESS_Z, 20);
            }
            else {
                translate([(0.5 * (IBEAM_X - SCREW_DIAM)), 0, 0]) translate([0, 0, IBEAM_THICKNESS_Z]) cube([SCREW_DIAM, IBEAM_Y, CLEARANCE_Z]);
                translate([0, 0, IBEAM_THICKNESS_Z + CLEARANCE_Z]) rounded_cube(IBEAM_X, IBEAM_Y, IBEAM_THICKNESS_Z, 20);
            }
        }
        ibeam_holes();
        if (TOP == 0) {
            translate([-0.25 * IBEAM_X, 0.2 * IBEAM_Y, (IBEAM_THICKNESS_Z + CLEARANCE_Z)]) cylinder(d1=SCREW_HEAD_DIAM, d2=SCREW_DIAM, h=IBEAM_THICKNESS_Z, $fn=64);
            translate([0.25 * IBEAM_X, 0.8 * IBEAM_Y, (IBEAM_THICKNESS_Z + CLEARANCE_Z)]) cylinder(d1=SCREW_HEAD_DIAM, d2=SCREW_DIAM, h=IBEAM_THICKNESS_Z, $fn=64);
        }
    }
}

module clip() {
    intersection() {
        difference() {
            union() {
                
                /*
                intersection() {
                    cylinder(d=BRACKET_Y, h=CLEARANCE_Z, $fn=64);
                    translate([0, 0, 0.5 * CLEARANCE_Z]) cube([SCREW_DIAM, BRACKET_Y, CLEARANCE_Z], center=true);
                }
                */
                translate([0, 0, -1 * TAB_THICKNESS]) hull() {
                    for(bx=[-1:2:1]) {
                        for(by=[-1:2:1]) {
                            translate([bx * (0.5 * (BRACKET_X - EDGE_CYL_DIAM)), by * (0.5 * (BRACKET_Y - EDGE_CYL_DIAM)), 0]) cylinder(h=TAB_THICKNESS, d=EDGE_CYL_DIAM, $fn=64);
                        }
                    }
                }
                
            }
            translate([0, 0, -1 * TAB_THICKNESS]) union() {
                cylinder(d=SCREW_DIAM + FUDGE, h=CLEARANCE_Z + CYLINDER_THICKNESS, $fn=64);
                //cylinder(d1=SCREW_HEAD_DIAM, d2=SCREW_DIAM, h=SCREW_HEAD_Z, $fn=64);
            }
        }
        //translate([0, 0.5 * BRACKET_Y, (0.5 * BIG_CYL_DIAM) - TAB_THICKNESS]) rotate([90, 0, 0]) cylinder(d=BIG_CYL_DIAM, h=BRACKET_Y, $fn=128);
    }
}

//ibeam(1);

translate([50, 0, 0]) ibeam(0);

// edge clip
/*
intersection() {
    clip();
    union() {
        translate([0, 0, -1 * TAB_THICKNESS]) cylinder(d=BRACKET_Y, h=CLEARANCE_Z + TAB_THICKNESS, $fn=64);
        translate([0, -0.5 * BRACKET_Y, -1 * TAB_THICKNESS]) cube([0.5 * BRACKET_X, BRACKET_Y, CLEARANCE_Z + TAB_THICKNESS]);
    }
}
*/


// middle clip
//translate([0, 2 * BRACKET_Y, 0]) clip();