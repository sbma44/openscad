BRACKET_LENGTH = 10;
CORD_DIAM = 10;
MARGIN = 5;
SCREW_DIAM = 3.5;
DRYWALL_ANCHOR_DIAM = 4;
DRYWALL_ANCHOR_HEAD_DIAM = CORD_DIAM; //8;
ANCHOR_DIAM = 4;

module woodscrew_hole() {
    translate([0, 0, -1]) cylinder(d=SCREW_DIAM, h=16, $fn=64);
    #translate([0, 0, -5]) cylinder(d1=8, d2=SCREW_DIAM, h=4, $fn=64);
    translate([0, 0, -35]) cylinder(d=8, h=30, $fn=64);
}

intersection() {
//difference() {
    difference() {
        translate([0.5 * BRACKET_LENGTH, 0, 0]) rotate([0, -90, 0]) difference() {
            hull() {
                translate([0, -0.5 * (CORD_DIAM + (4*MARGIN)), 0]) cube([1.0 * (CORD_DIAM + MARGIN), CORD_DIAM + (4*MARGIN), BRACKET_LENGTH]);
                cylinder(d=CORD_DIAM+MARGIN, h=BRACKET_LENGTH, $fn=64);
            }
            cylinder(d=CORD_DIAM, h=BRACKET_LENGTH, $fn=64);
        }
        cylinder(d=DRYWALL_ANCHOR_DIAM, h=CORD_DIAM * 2, $fn=64);
        cylinder(d=DRYWALL_ANCHOR_HEAD_DIAM, h=0.8 * CORD_DIAM, $fn=64);
        translate([0, CORD_DIAM, 4]) {
            woodscrew_hole();
        }
        translate([0, -1 * CORD_DIAM, 4]) {
            woodscrew_hole();
        }
    }
    union() {
        DROP = 1;
        translate([1.414 * 0.5 * -10, -50, DROP]) scale([1, 1, 0.5]) rotate([0, 45, 0]) cube([10, 100, 10]);
        translate([-25, -25, -50]) cube(50);
    }
}