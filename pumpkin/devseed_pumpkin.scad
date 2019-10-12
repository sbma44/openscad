use <DoubleFeature21.ttf>;

module pumpkin(l) {
    import(str("shell_", l % 2, ".stl"));
}

s = "DEVSEED";
module letter(l) {
    difference() {
        difference() {
            difference() {    
                pumpkin();
                translate([0, -50, -50]) cube([100, 100, 100]);
            }
            
            difference() {
                translate([0, 0, 1.2]) scale([0.9, 0.9, 0.9]) pumpkin(l);
                translate([0, 0, -23]) sphere(r=40, $fn=256);
            }
        }
        translate([0, 0, 6]) rotate([90, 0, -90]) linear_extrude(height=20) text(s[l], font="Double Feature", halign="center");
    }
}

l = 0;
letter(l);