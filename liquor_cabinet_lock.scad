INNER_DIAMETER = 20;
OUTER_DIAMETER = 38;
KNOB_DISTANCE_FROM_CENTER = 42;
CABLE_DIAMETER = 4; // but round up
CABLE_SEPARATION = 15;
RING_DIAMETER = 9;

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}

module knob_model() {
    circle(d=INNER_DIAMETER, $rn=36);
    translate([0, 0, 5]) circle(d=OUTER_DIAMETER, $rn=36);
}

/*translate([0, KNOB_DISTANCE_FROM_CENTER / 2, 0]) {
    knob_model();
    translate([0, -1 * KNOB_DISTANCE_FROM_CENTER, 0]) knob_model();
}*/


difference() {
    translate([0, KNOB_DISTANCE_FROM_CENTER / 2, 0]) {
        union() {
            rotate_extrude(angle=180) translate([(RING_DIAMETER + INNER_DIAMETER + 4) / 2, 0, 0])  circle(d=RING_DIAMETER, $fn=36);
            CYLINDER_HEIGHT = (KNOB_DISTANCE_FROM_CENTER / 2) - 2;
            translate([(RING_DIAMETER + INNER_DIAMETER + 4) / 2, 0, 0]) rotate([90, 0, 0]) cylinder(d=RING_DIAMETER, h=CYLINDER_HEIGHT, $fn=36);
            translate([(RING_DIAMETER + INNER_DIAMETER + 4) / -2, 0, 0]) rotate([90, 0, 0]) cylinder(d=RING_DIAMETER, h=CYLINDER_HEIGHT, $fn=36);
        }
    }
    translate([-50, CABLE_SEPARATION/2, 0]) rotate([0, 90, 0]) cylinder_outer(100, (CABLE_DIAMETER + 1) / 2, 36);
}