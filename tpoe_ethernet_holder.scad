DIM_X = 87;
DIM_Y = 95.1;
DIM_Z = 3;
EDGE = 5;
SCREW_Z = 8;
SCREW_DIAM = 3;
SCREW_INSET = 2.5;
BIG_SCREW_DIAM = 5;

CUBE_SIZE = 10;

module frame() {
    union() {
        difference() {
            cube([DIM_X, DIM_Y, DIM_Z], center=true);
            cube([DIM_X - (2*EDGE), DIM_Y - (2*EDGE), DIM_Z], center=true);
            for(ox=[-1:2:2]) {
                for(oy=[-1:2:2]) {       
                    translate([ox * ((0.5 * DIM_X) - SCREW_INSET), oy * ((0.5 * DIM_Y) - SCREW_INSET), -0.5 * DIM_Z]) cylinder(d=SCREW_DIAM, h=DIM_Z, $fn=64);
                }
            }
        }

        for(ox=[-1:2:2]) {
            for(oy=[-1:2:2]) {  
                translate([ox * (0.5 * (CUBE_SIZE + DIM_X)), oy * (0.5 * (DIM_Y - CUBE_SIZE)), -1]) {
                    difference() {
                        union() {
                            translate([0, 0, 1]) cube([CUBE_SIZE, CUBE_SIZE, DIM_Z], center=true);
                            translate([0, 0, -1 * (SCREW_Z - DIM_Z)]) cylinder(d=CUBE_SIZE, h=SCREW_Z - DIM_Z, $fn=64);
                        }
                        translate([0, 0, -0.5 * (SCREW_Z + DIM_Z)]) cylinder(d=BIG_SCREW_DIAM, h=SCREW_Z, $fn=64);
                    }
                }
            }
        }
    }

}

module standoff() {
    STANDOFF_HEIGHT = 8.5;
    difference() {
        cylinder(d=CUBE_SIZE, h=STANDOFF_HEIGHT, $fn=64);
        cylinder(d=BIG_SCREW_DIAM, h=STANDOFF_HEIGHT, $fn=64);
    }
}

standoff();
