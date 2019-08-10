module cylinder_outer(height,radius,fn) {
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

VACUUM_DIAM_WITH_SLOTS = 40.5;
VACUUM_DIAM=35.5;
LIP_DEPTH=3;
VACUUM_DEPTH=24.25 + LIP_DEPTH;
SLOT_WIDTH=2.5;
BUTTON_DIAM=14;
SLOT_RECESS=3;


SCALE_ELLIPSE = VACUUM_DIAM / (VACUUM_DEPTH - (LIP_DEPTH * 4));
SCALE_ELLIPSE_BIG = (VACUUM_DIAM_WITH_SLOTS + 4) / (VACUUM_DEPTH - (LIP_DEPTH * 4) + (VACUUM_DIAM_WITH_SLOTS - VACUUM_DIAM));

module arch() {
    intersection() {
        rotate([90, 0, 0]) linear_extrude(height=100, center=true) scale([  SCALE_ELLIPSE_BIG, 1, 1]) circle(d=VACUUM_DEPTH - (LIP_DEPTH * 4) + (VACUUM_DIAM_WITH_SLOTS - VACUUM_DIAM), $fn=64);
        translate([0, 1, (VACUUM_DIAM_WITH_SLOTS + 4) * 0.5]) rotate([90, 0, 0]) linear_extrude(height=2) square([VACUUM_DIAM_WITH_SLOTS + 4, VACUUM_DIAM_WITH_SLOTS + 4], center=true);                 
    }
}

module bottom() {
    translate([0, 0, -1 * VACUUM_DEPTH]) {
        difference() {
            difference() {
                difference() {   
                    cylinder_outer(VACUUM_DEPTH, (VACUUM_DIAM_WITH_SLOTS + 4) / 2, 64);
                    cylinder_outer(VACUUM_DEPTH, VACUUM_DIAM / 2, 64);
                }
                linear_extrude(height=VACUUM_DEPTH - SLOT_RECESS) {
                    square([VACUUM_DIAM_WITH_SLOTS, SLOT_WIDTH], center=true);
              };
            }
            translate([0, 0, (BUTTON_DIAM/2) + LIP_DEPTH]) rotate([-90, 0, 0]) cylinder(d=BUTTON_DIAM, h=30);
        }
    }
}

// slice top of bottom
module hook() {
    difference() {
        hull() {
            intersection() {
                bottom();
                translate([0, 0, -1]) cylinder_outer(1, (VACUUM_DIAM_WITH_SLOTS + 4) / 2, 64);
            }
            arch();
        }
        rotate([90, 0, 0]) linear_extrude(height=100, center=true) scale([SCALE_ELLIPSE, 1, 1]) circle(d=VACUUM_DEPTH - (LIP_DEPTH * 4), $fn=64);
    }
}

difference() {
    union() {
        bottom();
        hook();
    }
    rotate([90, 0, 0]) linear_extrude(height=100, center=true) scale([SCALE_ELLIPSE, 1, 1]) circle(d=VACUUM_DEPTH - (LIP_DEPTH * 4), $fn=64);
}