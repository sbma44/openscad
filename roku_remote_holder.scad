$fa=0.5;
$fp=1;

hole_depth=50;

module remote_outline() {
    translate([-21, -13.5, 0]) projection() rotate([-90, 0, 0])
    translate([0, -34]) import("Roku_Remote-StreamingStick-notag.STL"); // available from https://makerware.thingiverse.com/thing:1668957
}

union() {
    translate([0, -7, -1 * hole_depth]) intersection() {
        difference() {
            translate([0,-15, 0]) difference() {
                translate([0, 20, 0])
                linear_extrude(hole_depth) 
                    union() {
                        translate([0, -20, 0]) scale([1.25, 1.25])  remote_outline();
                        translate([-26, -8]) square([51.5, 10]);
                    }
                translate([0, 0, 3]) linear_extrude(hole_depth) scale([1.05, 1.05])  remote_outline();
            };
            translate([0, -4, 0]) linear_extrude(3) 
                intersection() {
                    scale([4, 2]) circle(r=5, $fn=36);
                    translate([0, -11, 0]) scale([1.05, 1.05]) remote_outline();
                }
        }
    
        translate([0, -10, 0]) union() {
            translate([-50, 5, 0]) cube([100, 100, 100]);
            translate([-50, -90, 47]) cube([100, 100, 3]);
            translate([-50, -90, 0]) cube([100, 100, 3]);
            for(i=[-100:15:100]) {
                translate([0 + i, -90, 48]) rotate([0, 45, 0]) cube([100, 100, 3]);
                translate([-50 + i, -90, -22]) rotate([0, -45, 0]) cube([100, 100, 3]);  
            }
        }
    }

    translate([25.75, 10, 0]) rotate([0, -90, 0]) linear_extrude(51.1) intersection() {
        translate([0, -20]) square([40,40]);
        difference() {
            circle(r=13.5);
            circle(r=10);
        }
    }
    
    translate([-25.75, 20, -10]) cube([51.5, 3.5, 10]);
}

