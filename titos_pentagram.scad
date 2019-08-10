include <threads.scad>

DIAMETER = 34;
PITCH = 3;
LENGTH = 8;

THICKNESS = 2;
TOTAL_HEIGHT = 18;

module pentagram(r, w=1, d=1) {
    linear_extrude(height=d) {
        for(a=[0:+(360/5):360]) {        
            rotate([0, 0, a]) 
                translate([-r, 0, 0]) rotate([0, 0, 18]) translate([w * 0.95, -0.5 * w]) square(size=[r, w]);
            rotate([0, 0, a])
                translate([-r, 0, 0]) rotate([0, 0, -1 * 18]) translate([w * 0.95, -0.5 * w]) square(size=[r, w]);
        }
        difference() {
            circle(r=r);
            circle(r=r-w);
        }
    }
}

difference() {
    hull() {
    translate([0, 0, 1]) rotate_extrude(convexity = 10, $fn=64) translate([(DIAMETER / 2) + 1, 0, 0]) circle(r = 1, $fn=32);
    translate([0, 0, 20]) rotate_extrude(convexity = 10, $fn=64) translate([(DIAMETER / 2) + 1, 0, 0]) circle(r = 1, $fn=32);
}
    union() {
        metric_thread(DIAMETER, PITCH, LENGTH, internal=true, n_starts=1);
        translate([0, 0, LENGTH]) cylinder(d=DIAMETER, h=TOTAL_HEIGHT-LENGTH, $fn=64);
        translate([0, 0, THICKNESS + TOTAL_HEIGHT + 0.5]) pentagram((DIAMETER/2) - 1, 1.5);
    }
}
