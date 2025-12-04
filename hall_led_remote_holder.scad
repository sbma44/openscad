REMOTE_X = 41;
REMOTE_Y = 9;
REMOTE_Z = 45;
CURVE = 6;
THICKNESS = 2;
D1=9;
D2=5;

module cone() {
    cylinder(d2=8, d1=4, h=THICKNESS, $fn=64);
}

difference() {
    translate([CURVE, 0, -1 * THICKNESS]) hull() {
        translate([-1 * (THICKNESS + CURVE), 0, 0]) cube([(2 * THICKNESS) + REMOTE_X, 1, REMOTE_Y + (2 * THICKNESS)]);
        translate([0, REMOTE_Z + THICKNESS, 0]) hull() {
                translate([REMOTE_X - (2 * CURVE), 0,  0]) cylinder(h=REMOTE_Y + (2 * THICKNESS), r=CURVE + THICKNESS, $fn=64);
                cylinder(h=REMOTE_Y + (2 * THICKNESS), r=CURVE + THICKNESS, $fn=64);

        }
    }


    hull() {
        cube([REMOTE_X, 40, REMOTE_Y]);
        translate([CURVE, REMOTE_Z + THICKNESS, 0]) hull() {
            cylinder(h=REMOTE_Y, r=CURVE, $fn=64);
            translate([REMOTE_X - (2 * CURVE), 0, 0]) cylinder(h=REMOTE_Y, r=CURVE, $fn=64);
        }
    }
    
    translate([THICKNESS, 0, 2 * THICKNESS]) hull() {
        cube([REMOTE_X - (2 * THICKNESS), 40, REMOTE_Y]);
        translate([CURVE + THICKNESS, REMOTE_Z, 0]) hull() {
            translate([-1 * THICKNESS, 0, 0]) cylinder(h=REMOTE_Y, r=CURVE, $fn=64);
            translate([REMOTE_X - (2 * CURVE) - (3 * THICKNESS), 0, 0]) cylinder(h=REMOTE_Y, r=CURVE, $fn=64);
        }
    }
    
    translate([(0.5 * REMOTE_X), 0.35 * REMOTE_Z, -1 * THICKNESS]) cone();
    translate([(0.5 * REMOTE_X), 0.85 * REMOTE_Z, -1 * THICKNESS]) cone();        
}