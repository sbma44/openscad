module rods() {
     rotate([0, 15, 0]) translate([0, 0, -60]) union() {
        rotate([0, -32.5, 0]) cylinder(d=10.5, h=200, center=false, $fn=32);
        rotate([0, -7.5, 0]) cylinder(d=10.5, h=200, center=false, $fn=32);
        translate([-2, 0, 0]) rotate([0, 17.5, 0]) cylinder(d=10.5, h=200, center=false, $fn=32);
    }
}

module screw() {
    union() {
        translate([0, -8.5, 0]) rotate([90, 0, 180]) 
        union() {
            cylinder(d=3, h=19, $fn=16);
            cylinder(d1=5, d2=3, h=2.5, $fn=32);
            translate([0,0,14.1]) linear_extrude(height=3) circle(r=3.75, $fn=6);
        }
    }
}

module screw_a() {
    translate([35, 0, 5]) screw();
}

module screw_b() {
    translate([-52, 0, 5]) screw();
}

module screw_c() {
    translate([15, 0, 15]) screw();
}

module ziptie() {
    cube([8, 2, 100]);
}    

module ziptie_a() {
    translate([2, -1, -50]) ziptie();
}

module ziptie_b() {
    translate([-27, -1, -50]) ziptie();
}

module front() {
    difference() {
        translate([-60, -14.25, 0]) difference() {
            cube([103, 14.25, 20]);
            translate([3, -3, 0]) cube([97, 9, 20]);
        }
        union() {
            rods();
            ziptie_a();
            ziptie_b();
            screw_a();
            screw_b();
            screw_c();
        }
    }
}


module back() {
    difference() {
        translate([-60, 0, 0]) cube([103, 8.5, 20]);
        union() {
            rods();
            ziptie_a();
            ziptie_b();
            screw_a();
            screw_b();
            screw_c();
        }
    }
}

//front();
translate([0, 10, 0]) back();