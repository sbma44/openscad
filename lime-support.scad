$fa=0.5;
$fp=1;

// tripod
rotate([90,0,0]) translate([50, 0, 0]) union() { 
    
    for(i=[1:3])
        rotate([20,120*i,0]) 
        union() {
            cylinder(h=30, d1=5, d2=3);
            translate([0,0,30]) sphere(3);
        };
    translate([0, 20]) rotate([90, 0, 0]) difference() {    
        cylinder(h=20, d=6.5, $fn=64);
        cylinder(h=20, d=4.5, $fn=64);
    };
}

// branch holder
translate([-15,0,0]) union() { 
    translate([0,10,0]) difference() {
        rotate_extrude(angle=180) translate([10, 0]) scale([0.25, 1]) circle(d=10);
        translate([-50,-3,-50]) cube([100, 100, 100]);
    }
    rotate([90, 0, 0]) difference() {    
        cylinder(h=25, d=6.5, $fn=64);
        cylinder(h=25, d=4.5, $fn=64);
    }
}


// pot thingy
union() {
    
    // rod holder
    translate([6.25, 0, -1.8])
    rotate([0, 20, 0]) 
    difference() {    
        cylinder(h=25, d=6.5, $fn=64);
        cylinder(h=25, d=4.5, $fn=64);
    }
    
    // clip
    translate([-113.25, 0, -28]) // shift to origin
    intersection() { // take slice of ring

        translate([0, -10, 0]) cube([200, 20, 40]);
        difference() {
            // outer ring
            linear_extrude(height=28) difference() {
                circle(d=253.5);
                circle(d=226.5);
            }
    
            // inner ring
            linear_extrude(height=25) difference() {
                circle(d=250.5);
                circle(d=229.5);
            }
        }
    }  
}