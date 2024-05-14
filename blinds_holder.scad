INCH_TO_MM = 25.4;
SCREW_HOLE_DIAM = 4;
HOLE_OFFSET = 27.5;

difference() {
    hull() {
        cylinder(d=12, h=0.5 * INCH_TO_MM, $fn=64);
        translate([0, HOLE_OFFSET, 0]) cylinder(d=12, h=0.5 * INCH_TO_MM, $fn=64);
        translate([0.5 * HOLE_OFFSET, 0.55 * HOLE_OFFSET, 0]) cylinder(d=12, h=0.1 * INCH_TO_MM, $fn=64);
    }
    translate([0, HOLE_OFFSET, 0]) cylinder(d=SCREW_HOLE_DIAM, h=0.5 * INCH_TO_MM, $fn=64);
    cylinder(d=SCREW_HOLE_DIAM, h=0.5 * INCH_TO_MM, $fn=64);
}
    
