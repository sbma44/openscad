WALL_WIDTH = 3;
CAMERA_DIMENSIONS = [108, 62, 33];
LENS_DIAM = 55;
ROD_DIAM = 7;
LENS_OFFSET = 15;
DOOR_OFFSET = [46 + WALL_WIDTH, 5 + WALL_WIDTH, CAMERA_DIMENSIONS[2] - 7.5];
BUTTON_OFFSET = [37, WALL_WIDTH, CAMERA_DIMENSIONS[2] - 14];
FLASH_OFFSET = [31, WALL_WIDTH, 12.];
NUT_INSET = 9;
M3_SHAFT_DIAM = 3;
FUDGE=1.05;
SIDE_BOLT_LENGTH = 17;
SIDE_HINGE_DIAM = 6;
BUTTON_DIAM = 18;

module m3_nut() {
    cylinder(d=FUDGE * 6, h=FUDGE * 2.4, $fn=6);
}

module cylinder_outer(height,diam,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,d=diam*fudge,$fn=fn);
}


module camera_case() {
    difference() {    
        union() {
            // shell
            hull() {
                for(x=[0,1]) {
                    for(y=[0,1]) {
                        for(z=[0,1]) {
                            translate([CAMERA_DIMENSIONS[0] * x, CAMERA_DIMENSIONS[1] * y, CAMERA_DIMENSIONS[2] * z]) sphere(r=WALL_WIDTH, $fn=64);
                        }
                    }
                }
            }
            
            // hinge 1
            translate([(-2 * WALL_WIDTH), (0.25 * CAMERA_DIMENSIONS[1]) + (0.165 * SIDE_BOLT_LENGTH), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) {
                hull() {
                    rotate([90, 0, 0]) cylinder(d=SIDE_HINGE_DIAM, h=0.33 * SIDE_BOLT_LENGTH, $fn=64);
                    translate([WALL_WIDTH, -0.33 * SIDE_BOLT_LENGTH, -1.5 * SIDE_HINGE_DIAM]) cube([1, 0.33 * SIDE_BOLT_LENGTH, 2 * SIDE_HINGE_DIAM]);
                }
            }
            
            // hinge 2
            translate([(-2 * WALL_WIDTH), (0.75 * CAMERA_DIMENSIONS[1]) + (0.165 * SIDE_BOLT_LENGTH), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) {
                hull() {
                    rotate([90, 0, 0]) cylinder(d=SIDE_HINGE_DIAM, h=0.33 * SIDE_BOLT_LENGTH, $fn=64);
                    translate([WALL_WIDTH, -0.33 * SIDE_BOLT_LENGTH, -1.5 * SIDE_HINGE_DIAM]) cube([1, 0.33 * SIDE_BOLT_LENGTH, 2 * SIDE_HINGE_DIAM]);
                }
            }
            
            // hinge 3
            translate([SIDE_HINGE_DIAM + CAMERA_DIMENSIONS[0], (0.25 * CAMERA_DIMENSIONS[1]) + (0.165 * SIDE_BOLT_LENGTH), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) {
                hull() {
                    rotate([90, 0, 0]) cylinder(d=SIDE_HINGE_DIAM, h=0.33 * SIDE_BOLT_LENGTH, $fn=64);
                    translate([(-0.5 * SIDE_HINGE_DIAM) - 1, -0.33 * SIDE_BOLT_LENGTH, -1.5 * SIDE_HINGE_DIAM]) cube([1, 0.33 * SIDE_BOLT_LENGTH, 2 * SIDE_HINGE_DIAM]);
                }
            }
            
            // hinge 4
            translate([SIDE_HINGE_DIAM + CAMERA_DIMENSIONS[0], (0.75 * CAMERA_DIMENSIONS[1]) + (0.165 * SIDE_BOLT_LENGTH), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) {
                hull() {
                    rotate([90, 0, 0]) cylinder(d=SIDE_HINGE_DIAM, h=0.33 * SIDE_BOLT_LENGTH, $fn=64);
                    translate([(-0.5 * SIDE_HINGE_DIAM) - 1, -0.33 * SIDE_BOLT_LENGTH, -1.5 * SIDE_HINGE_DIAM]) cube([1, 0.33 * SIDE_BOLT_LENGTH, 2 * SIDE_HINGE_DIAM]);
                }
            }
            
        }
        // subtract all this stuff
        union() {
            // make a hole in the box
            cube(CAMERA_DIMENSIONS);
            
            // cut off back
            translate([-1 * WALL_WIDTH, -1 * WALL_WIDTH, CAMERA_DIMENSIONS[2]]) scale([1.1, 1.1, 1]) cube(CAMERA_DIMENSIONS);

            // lens hole
            translate([(0.5 * LENS_DIAM) + LENS_OFFSET, 0.5 * LENS_DIAM, -1 * WALL_WIDTH]) cylinder(d=LENS_DIAM, h=WALL_WIDTH, $fn=64);

            // battery/SD door hole
            translate([WALL_WIDTH + CAMERA_DIMENSIONS[0] - DOOR_OFFSET[0], -1 * WALL_WIDTH, 4]) cube(DOOR_OFFSET);

            // button hole
            translate([CAMERA_DIMENSIONS[0] - BUTTON_OFFSET[0], CAMERA_DIMENSIONS[1], 9]) {
                translate([(0.5 * BUTTON_DIAM), WALL_WIDTH, 4]) rotate([90, 0, 0]) cylinder(d=BUTTON_DIAM, h=WALL_WIDTH, $fn=64);
                cube(BUTTON_OFFSET);
            }
            

            // flash hole
            translate([2, CAMERA_DIMENSIONS[1], 3]) cube(FLASH_OFFSET);
            
            // captive nuts (bottom)
            for(x=[0,1]) {
                for(y=[0,1]) {
                    translate([(x * (CAMERA_DIMENSIONS[0] - (2*NUT_INSET))) + NUT_INSET, (y * (CAMERA_DIMENSIONS[1] - (2*NUT_INSET))) + NUT_INSET, -2])                 union() {
                        m3_nut();
                        translate([0, 0, -1]) cylinder_outer(WALL_WIDTH, M3_SHAFT_DIAM, 64);
                    }
                }
            }
            
            // captive nuts (sides)
            translate([(-1 * WALL_WIDTH) + 1, 15, (0.5 * CAMERA_DIMENSIONS[2]) - 3]) rotate([0, 90, 0]) {
                m3_nut();
                translate([0, 0, -1]) cylinder_outer(WALL_WIDTH, M3_SHAFT_DIAM, 64);
            }
            translate([CAMERA_DIMENSIONS[0] + 2, 15, (0.5 * CAMERA_DIMENSIONS[2]) - 3]) rotate([0, -90, 0]) {
                m3_nut();
                translate([0, 0, -1]) cylinder_outer(WALL_WIDTH, M3_SHAFT_DIAM, 64);
            }
            
            // hinges
            translate([(-0.5 * SIDE_HINGE_DIAM) - M3_SHAFT_DIAM, 0, CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([-90, 0, 0]) cylinder_outer(CAMERA_DIMENSIONS[1], M3_SHAFT_DIAM, 64);
            translate([CAMERA_DIMENSIONS[0] + (0.5 * SIDE_HINGE_DIAM) + M3_SHAFT_DIAM, 0, CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([-90, 0, 0]) cylinder_outer(CAMERA_DIMENSIONS[1], M3_SHAFT_DIAM, 64);
            
            // safety line
            translate([CAMERA_DIMENSIONS[0], 0.5 * CAMERA_DIMENSIONS[1], 0.5 * CAMERA_DIMENSIONS[2]]) scale([1, 1, 1.5]) rotate([0, 90, 0]) cylinder(d=10, h=WALL_WIDTH, $fn=64);
        }        
    }
}

module arm() {
    difference() {
        rotate([90, 0, 0]) cylinder(d=SIDE_HINGE_DIAM, h=SIDE_BOLT_LENGTH, $fn=64);
        translate([0, -0.35 * SIDE_BOLT_LENGTH, 0]) rotate([90, 0, 0]) cylinder(d=SIDE_HINGE_DIAM, h=0.35*SIDE_BOLT_LENGTH, $fn=64);
        translate([0, -1 * SIDE_BOLT_LENGTH, 0]) rotate([-90, 0, 0]) cylinder_outer(CAMERA_DIMENSIONS[1], M3_SHAFT_DIAM, 64);
    }
}

module arms() {
    SPAN_WIDTH = 0.5 * (((0.5 * CAMERA_DIMENSIONS[1]) + SIDE_BOLT_LENGTH) - ((0.5 * CAMERA_DIMENSIONS[1]) - SIDE_BOLT_LENGTH));

    difference() {
        union() {
            
            // left hinge
            translate([SIDE_HINGE_DIAM + CAMERA_DIMENSIONS[0], (0.25 * CAMERA_DIMENSIONS[1]) + (0.5 * SIDE_BOLT_LENGTH), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) arm();
            // right hinge
            translate([SIDE_HINGE_DIAM + CAMERA_DIMENSIONS[0], (0.75 * CAMERA_DIMENSIONS[1]) + (0.5 * SIDE_BOLT_LENGTH), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) arm();

            
            // inner circle
            translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([0, 90, 0]) difference() {
                translate([0, -0.5, 0]) cylinder(d=(0.5 * CAMERA_DIMENSIONS[1]) - (0.35 * SIDE_BOLT_LENGTH), h=SIDE_HINGE_DIAM, $fn=64);
                cylinder(d=(0.5 * CAMERA_DIMENSIONS[1]) - SIDE_BOLT_LENGTH, h=SIDE_HINGE_DIAM, $fn=64);
                translate([0, -0.5 * CAMERA_DIMENSIONS[1], 0]) cube([CAMERA_DIMENSIONS[0], CAMERA_DIMENSIONS[1], CAMERA_DIMENSIONS[2]]);
                translate([0, 0.5 * CAMERA_DIMENSIONS[1], 0.5 * SIDE_HINGE_DIAM]) rotate([90, 0, 0]) cylinder_outer(CAMERA_DIMENSIONS[1], M3_SHAFT_DIAM, 64);
            }
            
            // outer circle
            translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([0, 90, 0]) difference() {
                 cylinder(d=(0.5 * CAMERA_DIMENSIONS[1]) + SIDE_BOLT_LENGTH, h=SIDE_HINGE_DIAM, $fn=64);
                 translate([0, -0.5, 0]) cylinder(d=(0.5 * CAMERA_DIMENSIONS[1]) + (0.325 * SIDE_BOLT_LENGTH) + 1, h=SIDE_HINGE_DIAM, $fn=64);
                 translate([0, -0.5 * CAMERA_DIMENSIONS[1], 0]) cube([CAMERA_DIMENSIONS[0], CAMERA_DIMENSIONS[1], CAMERA_DIMENSIONS[2]]);
                 translate([0, 0.5 * CAMERA_DIMENSIONS[1], 0.5 * SIDE_HINGE_DIAM]) rotate([90, 0, 0]) cylinder_outer(CAMERA_DIMENSIONS[1], M3_SHAFT_DIAM, 64);
            }
            
            // fin
            translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([0, 90, 0]) difference() {
                translate([0, 0, 0.25 * SIDE_HINGE_DIAM]) cylinder(d=(0.5 * CAMERA_DIMENSIONS[1]) + SIDE_BOLT_LENGTH, h=0.5 * SIDE_HINGE_DIAM, $fn=64);
                translate([-0.75 * SIDE_HINGE_DIAM, -0.5 * CAMERA_DIMENSIONS[1], 0]) cube(CAMERA_DIMENSIONS);
            }
            
            // disc
            translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([0, 90, 0]) difference() {
                translate([-0.5 * ((0.5 * CAMERA_DIMENSIONS[1]) + SIDE_BOLT_LENGTH) + (0.5 * SIDE_BOLT_LENGTH), 0, 0]) cylinder(d=SIDE_BOLT_LENGTH, h=SIDE_HINGE_DIAM, $fn=64);        
            }
            
            
            // extender
            translate([0, -1 * SIDE_HINGE_DIAM, (0.5 * SIDE_HINGE_DIAM) + (0.25 * CAMERA_DIMENSIONS[1])]) translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) 
                cube([SIDE_HINGE_DIAM, 2* SIDE_HINGE_DIAM, 0.5 * SPAN_WIDTH]);
        }
        // rod hole
        translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) rotate([0, 90, 0]) 
        translate([-0.5 * ((0.5 * CAMERA_DIMENSIONS[1]) + SIDE_BOLT_LENGTH) + (0.5 * SIDE_BOLT_LENGTH), 0, 0]) cylinder(d=ROD_DIAM, h=SIDE_HINGE_DIAM, $fn=64);
        
        
        // captive nut
        translate([0.5 * SIDE_HINGE_DIAM, 0, (0.5 * ((0.5 * CAMERA_DIMENSIONS[1]) - SIDE_BOLT_LENGTH)) + (0.85 * SPAN_WIDTH)]) translate([CAMERA_DIMENSIONS[0] + 0.5 * SIDE_HINGE_DIAM, (0.5 * CAMERA_DIMENSIONS[1]), CAMERA_DIMENSIONS[2] - (0.5 * SIDE_HINGE_DIAM)]) {
            translate([0, 0, -0.5 * SPAN_WIDTH]) cylinder_outer(SPAN_WIDTH, M3_SHAFT_DIAM, 64);
            m3_nut();
            translate([0, -0.5 * FUDGE * 5.2, 0]) cube([10, FUDGE * 5.2, FUDGE * 2.4]);
        }
    }
    
    
}

color("cyan") translate([0, 0.5, 0]) arms();
//camera_case();



