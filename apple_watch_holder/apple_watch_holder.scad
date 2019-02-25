 module cylinder_outer(height,radius,fn) {
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

module watch() {
    difference() {
        difference() {
            difference() {
                union() {
                    cylinder(d=38, h=8, $fn=64);
                    hull() rotate_extrude(angle=360) translate([17.75, 0, 0]) circle(d=2.5, $fn=36);
                    translate([-25, 0, 4]) difference() {
                        translate([0, 0, -1.25/2]) cube([35, 20, 9.25], center=true);
                        translate([-12.5, 0, 2.4]) cube([10, 15, 3.3], center=true);
                        translate([-12.5, 0, -3.6]) cube([10, 15, 3.3], center=true);
                    }
                }
                cylinder_outer(8, 14, 64);

            }
            translate([0, 0, -20]) cylinder(d=23, h=100, $fn=64);
        }    
        translate([-10, 0, -10]) hull() {
            cylinder(d=6, h=20, $fn=36);
            translate([-15, 0, 0]) cylinder(d=6, h=20, $fn=36);
        }
    }
}

module clip() {
    difference() {
        union() {
            // prongs
            translate([4, 0, 6.6]) cube([13, 14, 2.8], center=true);        translate([5, 0, 0.4]) cube([11, 14, 2.8], center=true);
            
            hull() {
                translate([-2.5,12.5,((28 - 5) / 2) - 5.75]) sphere(d=5, $fn=64);
                translate([-2.5,-12.5,((28 - 5) / 2) - 5.75]) sphere(d=5, $fn=64);
                translate([-2.5,12.5,((28 - 5) / 2) - 5.75 - 23]) sphere(d=5, $fn=64);
                translate([-2.5,-12.5,((28 - 5) / 2) - 5.75 - 23]) sphere(d=5, $fn=64);
                translate([-2.5 - 20,12.5,((28 - 5) / 2) - 5.75]) sphere(d=5, $fn
=64);
            translate([-2.5 - 20,-12.5,((28 - 5) / 2) - 5.75]) sphere(d=5, $fn=64);
            translate([-2.5 - 20,12.5,((28 - 5) / 2) - 5.75 - 23]) sphere(d=5, $fn=64);
            translate([-2.5 - 20,-12.5,((28 - 5) / 2) - 5.75 - 23]) sphere(d=5, $fn=64);
            }
        }
        translate([-15, 0, -5.75]) cube([20, 30, 18], center=true);
    }
}

$vpt = [0, 0, 0];
$vpd = 300;
$vpr = [45, 0, $t * 360];
render() {
    translate([47, 0, 0]) watch();
translate([-15, 0, 0]) clip();
}

    