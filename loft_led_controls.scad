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




KNOB_ROD_DIAM = 6;
KNOB_ROD_FUDGE = 0.2;
KNOB_ROD_FLAT_DIAM = 4.5;
KNOB_ROD_FLAT_HEIGHT = 10;
KNOB_ROD_HEIGHT = 20;
KNOB_WALL_PADDING = 4;
KNOB_CEILING_PADDING = 4;

KNOB_DIAM = 40;

KNOB_PADDING = KNOB_DIAM * 0.25;
KNOB_INDENT = 3;
KNOB_CLEARANCE = 3;
KNOB_HEIGHT = KNOB_CEILING_PADDING + KNOB_ROD_HEIGHT - (SOCKET_THICKNESS + KNOB_CLEARANCE);
KNOB_CURL_DIAM = 10;

CUBE_X = (2 * KNOB_DIAM) + (3 * KNOB_PADDING);
CUBE_Y = 2 * TRAPEZOID_Y;
CUBE_Z = KNOB_DIAM + (2 * KNOB_PADDING);


module torus(d1, d2) {
    rotate_extrude($fn=128) {
        translate([d1 * 0.5, 0, 0]) circle(d=KNOB_CURL_DIAM, $fn=64);
    }
}

module knob_shell(d, h) {
    union() {
        _KNOB_HEIGHT_ADJUSTED = h - (0.5 * KNOB_CURL_DIAM);
        translate([0, 0, _KNOB_HEIGHT_ADJUSTED]) hull() torus(d - KNOB_CURL_DIAM, KNOB_CURL_DIAM);
        cylinder(d=d, h=_KNOB_HEIGHT_ADJUSTED, $fn=128);
    }
}

module knob() {
    difference() {
        union() {
            difference () {
                knob_shell(KNOB_DIAM, KNOB_HEIGHT);
                translate([0, 0, -1 * KNOB_CEILING_PADDING]) knob_shell(KNOB_DIAM - (2 * KNOB_WALL_PADDING), KNOB_HEIGHT);
            }
            // rod holder
            translate([0, 0, KNOB_HEIGHT - (KNOB_CEILING_PADDING + KNOB_ROD_FLAT_HEIGHT)]) difference() {
                cylinder(h=KNOB_ROD_FLAT_HEIGHT, d=KNOB_ROD_DIAM + (2 * KNOB_WALL_PADDING), $fn=64);
                difference() {
                    _rod_diam = KNOB_ROD_DIAM + (2 * KNOB_ROD_FUDGE);
                    cylinder(h=KNOB_ROD_FLAT_HEIGHT, d=_rod_diam, $fn=64);
                    translate([(0.5 * _rod_diam) - (KNOB_ROD_DIAM - KNOB_ROD_FLAT_DIAM) + KNOB_ROD_FUDGE, -0.5 * _rod_diam, 0]) cube([_rod_diam, _rod_diam, KNOB_ROD_FLAT_HEIGHT]);
                }
            }
        }
    
        
        
        NUM_DENTS = 12;
        ROT_FRAC = 360.0 / NUM_DENTS;
        for(i=[0:1:NUM_DENTS]) {
            rotate([0, 0, i * ROT_FRAC]) scale([1, 1, 1]) translate([0.55 * KNOB_DIAM, 0, 0.85 * KNOB_HEIGHT]) sphere(d=KNOB_CURL_DIAM, $fn=128);
        }
        
    }
}

module mount() {

    WING_DIAM = SOCKET_Y;
    WING_THICKNESS = CUBE_Y - (TRAPEZOID_Y + TRAPEZOID_FUDGE);
    
    SCREW_INSET_DIAM=10;
    SCREW_DIAM = 4.5;
    
    ENCODER_X = 13;
    
    
    union() {
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
                
                // inset rings
                translate([(0.5 * KNOB_DIAM) + KNOB_PADDING, CUBE_Y, 0.5 * CUBE_Z]) rotate([-90, 0, 0]) difference() {
                    cylinder(d=KNOB_DIAM + 5, h=3, $fn=64);
                    cylinder(d=KNOB_DIAM + 1, h=3, $fn=64);
                }
                translate([(1.5 * KNOB_DIAM) + (2 * KNOB_PADDING), CUBE_Y, 0.5 * CUBE_Z]) rotate([-90, 0, 0]) difference() {
                    cylinder(d=KNOB_DIAM + 5, h=3, $fn=64);
                    cylinder(d=KNOB_DIAM + 1, h=3, $fn=64);
                }
            }
            translate([SOCKET_THICKNESS, -1 * WING_THICKNESS, SOCKET_THICKNESS]) cube([CUBE_X - (SOCKET_THICKNESS * 2), CUBE_Y + WING_THICKNESS - SOCKET_THICKNESS, CUBE_Z - (SOCKET_THICKNESS * 2)]);

            ENCODER_SCREW_HOLE_DIAM = 8.5;
            translate([(0.5 * KNOB_DIAM) + KNOB_PADDING, 0, 0.5 * CUBE_Z]) rotate([-90, 0, 0]) cylinder(d=ENCODER_SCREW_HOLE_DIAM, h=CUBE_Y + WING_THICKNESS, $fn=64);
            translate([(1.5 * KNOB_DIAM) + (2 * KNOB_PADDING), 0, 0.5 * CUBE_Z]) rotate([-90, 0, 0]) cylinder(d=ENCODER_SCREW_HOLE_DIAM, h=CUBE_Y + WING_THICKNESS, $fn=64);

            //translate([0.5 * (CUBE_X - (TRAPEZOID_X + (2 * TRAPEZOID_FUDGE))), CUBE_Y, SOCKET_THICKNESS]) _mounting_trapezoid(TRAPEZOID_X + (4 * TRAPEZOID_FUDGE), TRAPEZOID_Y + TRAPEZOID_FUDGE, SOCKET_Z);
            
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
        // encoder socket bars
        translate([(0.5 * KNOB_DIAM) + KNOB_PADDING - (0.5 * ENCODER_X) - SOCKET_THICKNESS, 0, 0]) difference() {
            cube([ENCODER_X + (2 * SOCKET_THICKNESS), CUBE_Y, CUBE_Z]);
            translate([SOCKET_THICKNESS, 0, 0]) cube([ENCODER_X, CUBE_Y, CUBE_Z]);
        }
        translate([(1.5 * KNOB_DIAM) + (2 * KNOB_PADDING) - (0.5 * ENCODER_X) - SOCKET_THICKNESS, 0, 0]) difference() {
            cube([ENCODER_X + (2 * SOCKET_THICKNESS), CUBE_Y, CUBE_Z]);
            translate([SOCKET_THICKNESS, 0, 0]) cube([ENCODER_X, CUBE_Y, CUBE_Z]);
        }
            
    }
}

module tray() {
    
    WING_DIAM = SOCKET_Y;
    WING_THICKNESS = CUBE_Y - (TRAPEZOID_Y + TRAPEZOID_FUDGE);
    
    SCREW_INSET_DIAM=10;
    SCREW_DIAM = 4.5;
    
    ENCODER_X = 13;

    LED_STRIP_CHANNEL_WIDTH_Z = 11 + SOCKET_FUDGE;
    LED_STRIP_CHANNEL_EDGE_HEIGHT = 2;
    LED_STRIP_CHANNEL_EDGE_WIDTH = 2;
    LED_STRIP_CHANNEL_BUFFER_X = 10;

    union() {
        difference() {
            hull() {
                for(i=[0:1:3]) {
                    translate([floor(i / 2) * CUBE_X, 0, (i % 2) * CUBE_Z + ((i%2) * -1 * WING_DIAM) + (0.5 * WING_DIAM)]) rotate([90, 0, 0]) cylinder(d=WING_DIAM + SOCKET_FUDGE + (2 * SOCKET_THICKNESS), h=WING_THICKNESS + SOCKET_THICKNESS, $fn=64);
                }
            }
            hull() {
                for(i=[0:1:3]) {
                    translate([floor(i / 2) * CUBE_X, 0, (i % 2) * CUBE_Z + ((i%2) * -1 * WING_DIAM) + (0.5 * WING_DIAM)]) rotate([90, 0, 0]) cylinder(d=WING_DIAM + SOCKET_FUDGE, h=WING_THICKNESS, $fn=64);
                }
            }
            
            // screw one
            translate([-0.25 * WING_DIAM, CUBE_Y, 0.5 * CUBE_Z]) rotate([90, 0, 0]) union() {
                //cylinder(h=CUBE_Y, d=SCREW_INSET_DIAM, $fn=64);
                cylinder(h=2 * CUBE_Y, d=SCREW_DIAM, $fn=64);
            }
            
            // screw two
            translate([(0.25 * WING_DIAM) + CUBE_X, CUBE_Y, 0.5 * CUBE_Z]) rotate([90, 0, 0]) union() {
                //cylinder(h=CUBE_Y, d=SCREW_INSET_DIAM, $fn=64);
                cylinder(h=2 * CUBE_Y, d=SCREW_DIAM, $fn=64);
            }
            
            AREA_OUTSIDE_CHANNEL_Z = 0.5 * (CUBE_Z - (LED_STRIP_CHANNEL_WIDTH_Z + (2 * LED_STRIP_CHANNEL_EDGE_WIDTH)));
            EXIT_HOLE_DIAM = 0.8 * AREA_OUTSIDE_CHANNEL_Z;
            #translate([0.5 * CUBE_X, -1 * (WING_THICKNESS + SOCKET_THICKNESS), 0.5 * AREA_OUTSIDE_CHANNEL_Z]) rotate([-90, 0, 0]) cylinder(d=EXIT_HOLE_DIAM, h=WING_THICKNESS, $fn=64);
        }
        
        translate([LED_STRIP_CHANNEL_BUFFER_X, -1 * WING_THICKNESS, (0.5 * (CUBE_Z + LED_STRIP_CHANNEL_WIDTH_Z)) + (-0.5 * LED_STRIP_CHANNEL_EDGE_WIDTH)]) {
            // strip channel edge (top)
            cube([CUBE_X - (2 * LED_STRIP_CHANNEL_BUFFER_X), LED_STRIP_CHANNEL_EDGE_HEIGHT, LED_STRIP_CHANNEL_EDGE_WIDTH]);
            
            // strip channel edge (bottom)
            translate([0, 0, -1 * LED_STRIP_CHANNEL_WIDTH_Z]) cube([CUBE_X - (2 * LED_STRIP_CHANNEL_BUFFER_X), LED_STRIP_CHANNEL_EDGE_HEIGHT, LED_STRIP_CHANNEL_EDGE_WIDTH]);
        }        
    }
}

//mount();
translate([0, -20, 0]) tray();
//knob();
//translate([(0.5 * KNOB_DIAM) + KNOB_PADDING, CUBE_Y, 0.5 * CUBE_Z]) rotate([-90, 0, 0]) knob();
//translate([(1.5 * KNOB_DIAM) + (2 * KNOB_PADDING), CUBE_Y, 0.5 * CUBE_Z]) rotate([-90, 0, 0]) knob();
