HOLE_DIAM = 16 + 1;
WIDTH = 20;
OFFSET=12;
BEVEL = 2;

difference() {
    hull() {
        for (r=[0:120:360]) {
            rotate([0, 0, r]) translate([OFFSET + BEVEL, 0, 0]) cylinder(d=(2 * BEVEL) + HOLE_DIAM, h=WIDTH, $fn=64);
        }
    }
    for (r=[0:120:360]) {
        rotate([0, 0, r]) translate([OFFSET + BEVEL, 0, 0]) cylinder(d=HOLE_DIAM, h=WIDTH, $fn=64);
    }
}