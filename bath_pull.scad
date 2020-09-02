SQUARE_WIDTH=16;
DIAM=19.5;
INNER_DIAM=14;
DEPTH=22;
BUFFER_BOTTOM=1.5;
BUFFER_TOP=3;
RING_DIAM=25;
RING_WIDTH=5;

difference() {
    difference(){
        union() {
            cylinder(d=DIAM, h=DEPTH + BUFFER_BOTTOM + BUFFER_TOP, $fn=128);
            translate([-0.5 * RING_WIDTH,0,DEPTH + BUFFER_BOTTOM + BUFFER_TOP + 7]) rotate([0, 90, 0]) {
                difference() {
                    cylinder(d=RING_DIAM, h=RING_WIDTH, $fn=128);
                    cylinder(d=RING_DIAM-5, h=RING_WIDTH, $fn=128);
                }
            }
        }
        translate([0,0,0]) cylinder(d=INNER_DIAM, h=DEPTH + BUFFER_BOTTOM, $fn=128);
    }
    union() {
        translate([-0.5 * SQUARE_WIDTH,-0.5*SQUARE_WIDTH,BUFFER_BOTTOM]) cube([SQUARE_WIDTH, SQUARE_WIDTH, DEPTH]);
        translate([0.5 * SQUARE_WIDTH, -0.5*SQUARE_WIDTH,BUFFER_BOTTOM]) cube([SQUARE_WIDTH, SQUARE_WIDTH, DEPTH]);

    }
}