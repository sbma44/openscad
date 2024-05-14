difference() {
    translate([0, -0.5 * 25, 0]) rotate([0, 0, 45]) difference() {
        rotate([0, 0, 45]) 
            translate([-0.5 * 25, -0.5 * 25, 0]) difference() {
                cube([25, 25, 11]);
                translate([0, 0, 2]) cube([21, 21, 7]);
            }
       translate([-50, -100, -15]) cube([100, 100, 30]);
       
    }
    translate([6, -3.4, 11 * 0.5]) rotate([-90, 0, 0]) #union() {
        cylinder(d1=8, d2=2.75, h=3.5, $fn=64);
        translate([0, 0, -20]) cylinder(d=8, h=20, $fn=64);
    }
    translate([-5, -3.4, 11 * 0.5]) rotate([-90, 0, 0]) #union() {
        cylinder(d1=8, d2=2.75, h=3.5, $fn=64);
        translate([0, 0, -20]) cylinder(d=8, h=20, $fn=64);
    }
}
