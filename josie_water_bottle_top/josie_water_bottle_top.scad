// water bottle top for josie
THICKNESS=3;
SVG_SCALE = 0.083;

ATTACHMENT_OUTER_CYLINDER_DIAM = 9;
OUTER_CYLINDER_LENGTH = 19;
ATTACHMENT_PIN_DIAM = 4.2;
PIN_LENGTH_BOTH = 24;

module footprint() {
//    Y_MODIFIER = 64.3 / 61.5;
    Y_MODIFIER = 0.985 * 64.3 / 63.5;
    X_MODIFIER = 0.98 * 19.0 / 20.0;
    linear_extrude(3) {
        scale([X_MODIFIER * SVG_SCALE, Y_MODIFIER * SVG_SCALE, 1]) import("footprint.svg", center=true);
    }
}
    
module cap_bump() {
    SCALE_X = 0.93;
    hull () {
        translate([0, 2.5, 22]) linear_extrude(3) {
            scale([(SCALE_X * SVG_SCALE), SVG_SCALE, 1]) import("top.svg", center=true);
        }
        
        translate([0, 2.5, 0]) linear_extrude(3) {
            BASE_MODIFIER = 0.022;
            scale([(SCALE_X * SVG_SCALE) + BASE_MODIFIER, SVG_SCALE + BASE_MODIFIER, 1]) import("top.svg", center=true);
        }
    }
}

module bottle_top() {
    difference() {
        difference() {
            union() {
                // cup/cap bump
                translate([0, 3.5, 0]) difference() {
                    union() {
                        translate([0, 3, 0]) cap_bump();
                        difference() {
                            footprint();
                            translate([-15, -33, 0]) cube([30, 5, THICKNESS]); // shave off the end near the hinge so that the sloped hull can allow it to rotate
                        }
                    }
                    BUMP_INTERIOR_SCALE_FACTOR = 21.0 / 26.0;
                    translate([0, 3, -1 * THICKNESS]) scale([BUMP_INTERIOR_SCALE_FACTOR, BUMP_INTERIOR_SCALE_FACTOR, 1]) cap_bump();
                }

                //hinge 
                difference() {
                    union () {
                        hull() {
                            intersection() {
                                translate([0, -27, -2.5]) rotate([0, 90, 0]) translate([0, 0, -0.5 * OUTER_CYLINDER_LENGTH]) cylinder(d=ATTACHMENT_OUTER_CYLINDER_DIAM + THICKNESS, h=OUTER_CYLINDER_LENGTH, $fn=64);
                                footprint();
                            }

                            translate([0, -27.6, -3]) rotate([0, 90, 0]) {
                                translate([0, 0, -0.5 * OUTER_CYLINDER_LENGTH]) cylinder(d=ATTACHMENT_OUTER_CYLINDER_DIAM, h=OUTER_CYLINDER_LENGTH, $fn=64);
                            }
                        }
                        translate([0, -27.6, -3]) rotate([0, 90, 0]) translate([0, 0, -0.5 * PIN_LENGTH_BOTH]) cylinder(d=ATTACHMENT_PIN_DIAM, h=PIN_LENGTH_BOTH, $fn=64);
                    }
                    NOTCH_X = 20 - (2 * THICKNESS);
                    translate([-0.5 * NOTCH_X, -30, -1 * ATTACHMENT_OUTER_CYLINDER_DIAM]) cube([NOTCH_X, ATTACHMENT_OUTER_CYLINDER_DIAM * 2, ATTACHMENT_OUTER_CYLINDER_DIAM]);
                }

                box_length_from_notch_to_center_pin = 57.11;

                // tab
                TAB_X = 10.9;
                TAB_Y = 4;
                TAB_Z = 5.6;
                TAB_NOTCH_X = 8.1;
                TAB_NOTCH_Y = 2.75;
                TAB_NOTCH_Z = 3.25;
                translate([0, 31, 0]) difference() {
                    translate([-0.5 * TAB_X, 0, -1 * TAB_Z]) cube([TAB_X, TAB_Y, TAB_Z]);
                    translate([-0.5 * TAB_NOTCH_X, TAB_Y - TAB_NOTCH_Y, -1 * TAB_NOTCH_Z]) cube([TAB_NOTCH_X, TAB_NOTCH_Y, TAB_NOTCH_Z]);
                    translate([0, 0, -7]) rotate([-45, 0, 0]) translate([-0.5 * TAB_X, 0, 0]) cube([TAB_X, TAB_Y, TAB_Z]);
                }
            }
            
            translate([10, 33, THICKNESS - 1]) rotate([180, 180, 0]) linear_extrude(10) text("JOJO", size=6);
        //        translate([0, 8, 20 + THICKNESS - 1]) rotate([0, 0, 180]) linear_extrude(10) scale([0.1, 0.1, 1]) import("lion3.svg", center=true);

        }
        #translate([0, 9, 20 + THICKNESS + 0.5]) rotate([0, 0, 0]) scale([1, 1, 0.2]) import("lion.clean.stl", center=true);
    }
}

difference() {
    bottle_top();
    //#translate([0, 7, THICKNESS]) cylinder(d=40, h=30, $fn=64);
}