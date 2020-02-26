module half_eagle() {
    intersection() {
        difference() {
            scale([1, 1, 0.5]) rotate([35, 13, 5]) intersection() {
                translate([3, -95, 0]) import("shoulder_eagle_simp.stl");
                translate([3, 30, -20]) rotate([-30, 0, 0]) translate([0, 0, -20]) cylinder(r=52, h=130);
            }
            translate([0, -200, -30]) cylinder(r=200, h=50, $fn=1024);
        }
        translate([-100, -100, -20]) cube([100, 200, 100]);
    }
}

union() {
    translate([0, 0, -3]) cylinder(h=3, r=40, $fn=128);
    scale([1, 1, 0.3]) {
        intersection() {
            translate([0, -36, -6]) union() {
                half_eagle();
                mirror(v=[1, 0, 0]) {
                    half_eagle();
                }
            }
            cylinder(r=40, h=100);
        }
    }
}