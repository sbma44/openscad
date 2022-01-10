FUDGE = 1.05;

DISC_WIDTH = 10;
DISC_DIAMETER = 40;
ROD_DIAMETER = 7;
FIN_THICKNESS = 5;

module m3_nut() {
    cylinder(d=FUDGE * 6, h=FUDGE * 2.4, $fn=6);
}

module diff_donut() {
    difference() {
        cylinder(r=(0.5 * DISC_DIAMETER) - FIN_THICKNESS, h=0.5 * (DISC_WIDTH-FIN_THICKNESS), $fn=128);
        cylinder(d=ROD_DIAMETER + FIN_THICKNESS, h=DISC_WIDTH, $fn=128);
    }
}

difference() {
    // main disc
    difference() {
        cylinder(r=0.5 * DISC_DIAMETER, h=DISC_WIDTH, $fn=128);
        cylinder(d=ROD_DIAMETER, h=DISC_WIDTH, $fn=128);
    }

    union() {
        // nut slot
        hull() {
            translate([(0.5 * ROD_DIAMETER) + (-0.5 * (DISC_DIAMETER - ROD_DIAMETER)), 0, 0.5 * DISC_WIDTH]) rotate([0, 90, 0]) m3_nut();
            translate([(0.5 * ROD_DIAMETER) + (-0.5 * (DISC_DIAMETER - ROD_DIAMETER)), 0, DISC_WIDTH]) rotate([0, 90, 0]) m3_nut();
        }
        // screw hole
        translate([-0.5 * DISC_DIAMETER, 0, 0.5 * DISC_WIDTH]) rotate([0, 90, 0]) cylinder(d=FUDGE * 3, h=0.5 * DISC_DIAMETER, $fn=64);
        // screw head inset
        translate([-0.5 * DISC_DIAMETER, 0, 0.5 * DISC_WIDTH]) rotate([0, 90, 0]) cylinder(d=FUDGE * 4.8, h=4, $fn=64);
        
    }
    
    // carveout
    difference() {
        union() {
            translate([0, 0, DISC_WIDTH - (0.5 * (DISC_WIDTH-FIN_THICKNESS))]) diff_donut();
            diff_donut();
        }
        translate([-0.5 * DISC_DIAMETER, -0.5 * (ROD_DIAMETER + FIN_THICKNESS), 0]) cube([0.5 * DISC_DIAMETER, ROD_DIAMETER + FIN_THICKNESS, DISC_WIDTH]);
    }
}



