FILENAME="pumpkin_simp_fixed_meshlab.stl";

module flat_pumpkin(n) {
    difference() {
        rotate([0, 0, n * (360 / 7)]) translate([-12, 12, 0]) rotate([90, 0, 0]) import(FILENAME, center=true);
        translate([-50, -50, -4]) cube([100, 100, 5]);
    }
}

module pumpkin(n) {
    rotate([0, 0, n * (360 / 7)]) translate([-13, 12, 0]) rotate([90, 0, 0]) import(FILENAME, center=true);
}


s = "DEVSEED";
module letter(l) {
    difference() {
        difference() {    
            pumpkin(l);
            translate([0, -50, -50]) cube([100, 100, 100]);
        }
        intersection() {
            translate([0, 0, 1.2]) scale([0.9, 0.9, 0.9]) pumpkin(l);
            translate([0, 0, -23]) sphere(r=40, $fn=256);
        }
    }
}

l = 0;
letter(l);