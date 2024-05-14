difference() {
    cube([37, 30, 11]);
    translate([24, 8, 0]) cylinder(d=3, h=11, $fn=64);
    translate([24, 8 + 14, 0]) cylinder(d=3, h=11, $fn=64);
}
    