// vacuum transformer holder


SOCKET_THICKNESS = 2;
SOCKET_FUDGE = 1;
SOCKET_X = 85 + SOCKET_FUDGE;
SOCKET_Y = 31 + SOCKET_FUDGE;
SOCKET_Z = 50;

M3_HEAD_Z = 3;
M3_HEAD_DIAM = 5.5;
M3_SHAFT_DIAM = 3;

TRAPEZOID_X = SOCKET_X - SOCKET_Y - 2;
TRAPEZOID_Y = 5;
TRAPEZOID_FUDGE = 1;

module _rounded_trapezoid(x, y, z, thickness) {
    hull() {
        diam = y + (2 * thickness);
        cylinder(d=diam, h=z + (2 * thickness), $fn=64);
        translate([x + (2 * thickness) - diam, 0, 0]) cylinder(d=diam, h=z + (2 * thickness), $fn=64);
    }

}
//
module _mounting_trapezoid(x, y, z) {
    mirror([0, 1, 0]) linear_extrude(z) polygon([[0 + y, 0], [x - y, 0], [x, y], [0, y], [0+y, 0]]);
}

module xformer_socket() {
    translate([(0.5 * SOCKET_Y) + SOCKET_THICKNESS, (0.5 * SOCKET_Y) + SOCKET_THICKNESS, 0]) difference() {
        union() {
            _rounded_trapezoid(SOCKET_X, SOCKET_Y, SOCKET_Z, SOCKET_THICKNESS);
            // m3 connector A
            translate([0.5 * (SOCKET_X - (2 * SOCKET_THICKNESS) - SOCKET_Y), 0.25 * SOCKET_Y, -1 * (M3_HEAD_Z + SOCKET_FUDGE)]) cylinder(d=M3_HEAD_DIAM + SOCKET_FUDGE + SOCKET_THICKNESS, h=M3_HEAD_Z + SOCKET_THICKNESS + SOCKET_FUDGE, $fn=64);
            // m3 connector B
            translate([0.5 * (SOCKET_X - (2 * SOCKET_THICKNESS) - SOCKET_Y), -0.25 * SOCKET_Y, -1 * (M3_HEAD_Z + SOCKET_FUDGE)]) cylinder(d=M3_HEAD_DIAM + SOCKET_FUDGE + SOCKET_THICKNESS, h=M3_HEAD_Z + SOCKET_THICKNESS + SOCKET_FUDGE, $fn=64);
        }
        translate([0, 0, SOCKET_THICKNESS]) _rounded_trapezoid(SOCKET_X, SOCKET_Y, SOCKET_Z + SOCKET_THICKNESS, 0);
        cylinder(d=0.8 * SOCKET_Y, h=SOCKET_THICKNESS, $fn=64);
        
        // m3 connector A
        translate([0.5 * (SOCKET_X - (2 * SOCKET_THICKNESS) - SOCKET_Y), 0.25 * SOCKET_Y, -1 * (M3_HEAD_Z + SOCKET_FUDGE) + SOCKET_THICKNESS]) cylinder(d=M3_HEAD_DIAM + SOCKET_FUDGE, h=M3_HEAD_Z + SOCKET_THICKNESS + SOCKET_FUDGE, $fn=64);
        translate([0.5 * (SOCKET_X - (2 * SOCKET_THICKNESS) - SOCKET_Y), 0.25 * SOCKET_Y, -1 * (M3_HEAD_Z + SOCKET_FUDGE)]) cylinder(d=M3_SHAFT_DIAM + SOCKET_FUDGE, h=M3_HEAD_Z + SOCKET_THICKNESS + SOCKET_FUDGE, $fn=64);
        // m3 connector B
        translate([0.5 * (SOCKET_X - (2 * SOCKET_THICKNESS) - SOCKET_Y), -0.25 * SOCKET_Y, -1 * (M3_HEAD_Z + SOCKET_FUDGE) + SOCKET_THICKNESS]) cylinder(d=M3_HEAD_DIAM + SOCKET_FUDGE, h=M3_HEAD_Z + SOCKET_THICKNESS + SOCKET_FUDGE, $fn=64);
        translate([0.5 * (SOCKET_X - (2 * SOCKET_THICKNESS) - SOCKET_Y), -0.25 * SOCKET_Y, -1 * (M3_HEAD_Z + SOCKET_FUDGE)]) cylinder(d=M3_SHAFT_DIAM + SOCKET_FUDGE, h=M3_HEAD_Z + SOCKET_THICKNESS + SOCKET_FUDGE, $fn=64);

    }
    
    translate([0.5 * (SOCKET_X + (2 * SOCKET_THICKNESS) - TRAPEZOID_X), 0, 2 * SOCKET_THICKNESS]) _mounting_trapezoid(TRAPEZOID_X, TRAPEZOID_Y, SOCKET_Z);
}

module socket_mount() {
    CUBE_X = (4 * SOCKET_THICKNESS) + TRAPEZOID_X + (2 * TRAPEZOID_FUDGE);
    CUBE_Y = 2 * TRAPEZOID_Y;
    CUBE_Z = SOCKET_Z + SOCKET_THICKNESS;
    WING_DIAM = SOCKET_Y;
    WING_THICKNESS = CUBE_Y - (TRAPEZOID_Y + TRAPEZOID_FUDGE);
    
    SCREW_INSET_DIAM=10;
    SCREW_DIAM = 4.5;
    
    rotate([0, 0, 180]) translate([-1 * SOCKET_THICKNESS, 0, 0]) {
            difference() {
            union() {
                hull() {
                    cube([CUBE_X, CUBE_Y, CUBE_Z]);
                    hull() {
                        for(i=[0:1:3]) {
                            translate([floor(i / 2) * CUBE_X, 0, (i % 2) * CUBE_Z + ((i%2) * -1 * WING_DIAM) + (0.5 * WING_DIAM)]) rotate([90, 0, 0]) cylinder(d=WING_DIAM, h=WING_THICKNESS, $fn=64);
                        }
                    }
                }
            }
            translate([0.5 * (CUBE_X - (TRAPEZOID_X + (2 * TRAPEZOID_FUDGE))), CUBE_Y, SOCKET_THICKNESS]) _mounting_trapezoid(TRAPEZOID_X + (4 * TRAPEZOID_FUDGE), TRAPEZOID_Y + TRAPEZOID_FUDGE, SOCKET_Z);
            
            // screw one
            translate([-0.25 * WING_DIAM, CUBE_Y, 0.5 * CUBE_Z]) rotate([90, 0, 0]) union() {
                cylinder(h=CUBE_Y, d=SCREW_INSET_DIAM, $fn=64);
                cylinder(h=2 * CUBE_Y, d=SCREW_DIAM, $fn=64);
            }
            
            // screw two
            translate([(0.25 * WING_DIAM) + CUBE_X, CUBE_Y, 0.5 * CUBE_Z]) rotate([90, 0, 0]) union() {
                cylinder(h=CUBE_Y, d=SCREW_INSET_DIAM, $fn=64);
                cylinder(h=2 * CUBE_Y, d=SCREW_DIAM, $fn=64);
            }
        }
    }
}

module socket_step() {
}

module cord_winder() {
}

xformer_socket();
//translate([0, -20, 0]) socket_mount();