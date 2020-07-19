use <threadlib/threadlib.scad>

SQUARE_WIDTH=16;
DIAM=19.5;
INNER_DIAM=14;
DEPTH=22;
BUFFER_BOTTOM=1.5;
BUFFER_TOP=3;
RING_DIAM=25;
RING_WIDTH=5;

 module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

// handle
module handle() {
    rotate([0, 0, 90]) translate([0, 10, 60]) rotate([90, 0, 0]) difference() {
        scale([0.95, 0.95, 1]) bolt("M18x2", turns=10);
        translate([0, 0, -10]) cylinder_outer(40, 4.2, 64);
    }
}

module base() {

    //base
    difference() {
        difference(){
            union() {
                cylinder(d=DIAM, h=DEPTH + BUFFER_BOTTOM + BUFFER_TOP, $fn=128);

                rotate([0, 0, 90]) translate([0, 10, DEPTH + BUFFER_TOP + 9 + 2]) rotate([90, 0, 0]) nut("M18x2", turns=10, Douter=DIAM + (2 * BUFFER_TOP));
                /*
                translate([-0.5 * RING_WIDTH,0,DEPTH + BUFFER_BOTTOM + BUFFER_TOP + 7]) rotate([0, 90, 0]) {
                    difference() {
                        cylinder(d=RING_DIAM, h=RING_WIDTH, $fn=128);
                        cylinder(d=RING_DIAM-5, h=RING_WIDTH, $fn=128);
                    }
                }
                */
            }
            translate([0,0,0]) cylinder(d=INNER_DIAM, h=DEPTH + BUFFER_BOTTOM, $fn=128);
        }
        union() {
            translate([-0.5 * SQUARE_WIDTH,-0.5*SQUARE_WIDTH,BUFFER_BOTTOM]) cube([SQUARE_WIDTH, SQUARE_WIDTH, DEPTH]);
            translate([0.5 * SQUARE_WIDTH, -0.5*SQUARE_WIDTH,BUFFER_BOTTOM]) cube([SQUARE_WIDTH, SQUARE_WIDTH, DEPTH]);

        }
    }
}

handle();
