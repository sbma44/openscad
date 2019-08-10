TOOTH_WIDTH = 4;
TOOTH_HEIGHT = 1;
PRIMARY_DIAMETER = 9.75;
DISC_HEIGHT = 0.75;
INSET = 1.0;
DISC_OUTER_DIAMETER = 16;

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

    difference() {
        union() {
            difference() {
                cylinder(d=DISC_OUTER_DIAMETER, h=DISC_HEIGHT + 1);
                cylinder(d=DISC_OUTER_DIAMETER-2, h=DISC_HEIGHT + 1);
            }
            difference() {
                cylinder(d=DISC_OUTER_DIAMETER, h=DISC_HEIGHT);
                intersection() {
                    cylinder_outer(DISC_HEIGHT, PRIMARY_DIAMETER/2, 64);
                    linear_extrude(height=DISC_HEIGHT) square([PRIMARY_DIAMETER, PRIMARY_DIAMETER - (INSET * 2)], center=true);
                }
            }
            
        }
        union() {
            translate([0, (DISC_OUTER_DIAMETER/2) - (TOOTH_HEIGHT/2), 0]) linear_extrude(height=DISC_HEIGHT + 1) square([TOOTH_WIDTH, 2], center=true);
            translate([0, (DISC_OUTER_DIAMETER/-2) + (TOOTH_HEIGHT/2), 0]) linear_extrude(height=DISC_HEIGHT + 1) square([TOOTH_WIDTH, 2], center=true);
        }
    }