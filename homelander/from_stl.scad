difference() {
    translate([0, -40, 3]) import("shoulder_eagle_0.1.stl");
    union() {
        cylinder(r2=18, r1=33, h=30);
        translate([0, -25, -75]) rotate([90, 0, 0]) cylinder(r=80, h=50, center=true);
    }
}