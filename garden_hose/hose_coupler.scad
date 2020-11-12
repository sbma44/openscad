// hose coupler for spooky tricks

rotate([0, 90, 0]) intersection() {
    difference() {
        union() {
            translate([5, 0, 0]) import("Female_Hose_Fitting/Hose_Fitting_Solid_v3.stl");
            mirror([1, 0, 0]) translate([5, 0, 0]) import("Female_Hose_Fitting/Hose_Fitting_Solid_v3.stl");
        }
        rotate([0, 90, 0]) translate([0, 0, -25]) cylinder(d=25, h=50, $fn=64);
    }
    rotate([0, 90, 0]) translate([0, 0, -25]) cylinder(d=37, h=50, $fn=64);
}