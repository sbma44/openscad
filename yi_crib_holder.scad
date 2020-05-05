OUTER_DIAM=34;
PVC_THICKNESS=3.85;
THICKNESS=1.5;
HEIGHT=15;
ROD_THICKNESS=4;
OFFSET_FROM_CENTER=12.5;
HOLE_DIAM=4;
DISC_HEIGHT=75;
ROD_ANGLE=10;
GUSSET_HEIGHT=5;
MIDDLE_HEIGHT=10;
D1 = OUTER_DIAM;

module bottom() {
    union() {
        difference() {
            difference(){
                cylinder(d=D1 + (2*THICKNESS), h=HEIGHT, $fn=128);
                difference() {                
                    cylinder(d=D1, h=HEIGHT, $fn=128);
                    cylinder(d=D1-(2*PVC_THICKNESS), h=HEIGHT, $fn=128);
                }
            }
            cylinder(d=D1-(2*(THICKNESS + PVC_THICKNESS)), h=HEIGHT, $fn=128);          
        }         
        translate([0, 0, HEIGHT - THICKNESS]) cylinder(d=D1 + (2*THICKNESS), h=THICKNESS, $fn=128);
    }
}

module middle() {
    difference() {
        cylinder(d=D1 + (2*THICKNESS), h=MIDDLE_HEIGHT, $fn=128);
        union() {
            for(i=[0:2]) {
                rotate([0, 0, i * 120]) translate([(0.5 * D1) + THICKNESS, 0, 0]) rotate([0, 0, 0]) cylinder(d=6*HOLE_DIAM, h=4* MIDDLE_HEIGHT, $fn=128);
            }
        }
    }
}

module top() {
    difference() {
        cylinder(d=D1 + (2*THICKNESS), h=THICKNESS, $fn=128);
        union() {
            for(i=[0:2]) {
                rotate([0, 0, 120*i]) translate([OFFSET_FROM_CENTER, 0, 0]) cylinder(d=HOLE_DIAM, h=THICKNESS, $fn=128);
            }
        }
    }
}



/*module top() {
    translate([0, 0, DISC_HEIGHT]) difference() {
        union() {
            cylinder(r=OFFSET_FROM_CENTER + HOLE_DIAM + THICKNESS + 1, h=THICKNESS, $fn=128);
            translate([0, 0, -1 * DISC_HEIGHT]) for(i=[0:2]) {
                difference() {
                    rotate([ROD_ANGLE, 0, 120 * i]) translate([0, 0, 2 + (DISC_HEIGHT / cos(ROD_ANGLE)) - GUSSET_HEIGHT]) cylinder(d=ROD_THICKNESS + (2*THICKNESS), h=GUSSET_HEIGHT, $fn=128);
                    rotate([ROD_ANGLE, 0, 120 * i]) color("black") cylinder(d=ROD_THICKNESS, h=100, $fn=128);
                }
            }
        }
        union() {
            for(i=[0:2]) {
                rotate([0, 0, (120*i) + 90]) translate([OFFSET_FROM_CENTER, 0, 0]) cylinder(d=HOLE_DIAM, h=THICKNESS, $fn=128);
            }
            translate([-20, -20, THICKNESS]) cube([40, 40, 40]);
        }
    }
}*/
union() {
    translate([0, 0, MIDDLE_HEIGHT]) top();
    color("red") middle();
    translate([0, 0, -1 * HEIGHT]) bottom();
}