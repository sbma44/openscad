WEDGE_ANGLE = atan(7.5/29.75);
BOARD_X = 63;
BOARD_Y = 19.05;
BANNISTER_X = 92; // error in here
DEFAULT_THICKNESS = 5;
BRACKET_Z = 34;
WEDGE_Z = 20;

ZIPTIE_Z = 4.5;
ZIPTIE_Y = 1.25;


module wedge() {
    // wedge
    S = sin(WEDGE_ANGLE) * BOARD_X;
    T = sqrt(pow(S, 2) + pow(BOARD_X, 2));
    Q = sin(WEDGE_ANGLE) * T;
    R = sin(WEDGE_ANGLE) * Q;
    difference() {
        union() {
            intersection() {
                translate([R, (-1 * Q), 0]) rotate([0, 0, WEDGE_ANGLE]) union() {
                    cube([BOARD_X, Q + 1, WEDGE_Z]);
                    translate([-1 * DEFAULT_THICKNESS, -1 * DEFAULT_THICKNESS, 0]) cube([DEFAULT_THICKNESS, Q + (2 * DEFAULT_THICKNESS), WEDGE_Z]);
                    translate([BOARD_X, -1 * DEFAULT_THICKNESS, 0]) cube([DEFAULT_THICKNESS, Q + DEFAULT_THICKNESS, WEDGE_Z]);
                }
                translate([-2 * R, -2 * S, 0]) cube([T + (4*DEFAULT_THICKNESS), 2 * S, WEDGE_Z]);
            }
            
            // bracket plate that mounts to wedge
            BRACKET_X = BANNISTER_X; // + (2 * DEFAULT_THICKNESS);
            WING_HYPOTENUSE = 1 / (cos(WEDGE_ANGLE) / DEFAULT_THICKNESS);
            
            WING_DEPTH = 4 * DEFAULT_THICKNESS;
            
            translate([-0.5 * (BRACKET_X - (cos(WEDGE_ANGLE) * (BOARD_X + DEFAULT_THICKNESS))), 0, -0.5 * (BRACKET_Z - WEDGE_Z)]) {
                difference() {
                    union() {
                        cube([BRACKET_X, DEFAULT_THICKNESS, BRACKET_Z]);
                        translate([-1 * DEFAULT_THICKNESS, 0, 0]) cube([DEFAULT_THICKNESS, WING_DEPTH, BRACKET_Z]);
                        translate([BRACKET_X, 0, 0]) cube([DEFAULT_THICKNESS, WING_DEPTH, BRACKET_Z]);
                    }

                    ZIPTIE_INSET_Z = (0.5 * (BRACKET_Z - WEDGE_Z)) - ZIPTIE_Z;
                    ///#translate([(-1 * DEFAULT_THICKNESS) - 10, 10, ZIPTIE_INSET_Z - 0.5]) rotate([0, 0, -45]) cube([BRACKET_X + (2 * DEFAULT_THICKNESS), ZIPTIE_Y, ZIPTIE_Z]);                    
                    //#translate([(-1 * DEFAULT_THICKNESS) - 10, 10, BRACKET_Z - (ZIPTIE_Z + ZIPTIE_INSET_Z) + 0.5]) rotate([0, 0, -45]) cube([BRACKET_X + (2 * DEFAULT_THICKNESS), ZIPTIE_Y, ZIPTIE_Z]);                    
                    
                    // main face original
                    //translate([-1 * DEFAULT_THICKNESS, 0, ZIPTIE_INSET_Z - 0.5]) cube([BRACKET_X + (2 * DEFAULT_THICKNESS), ZIPTIE_Y, ZIPTIE_Z]);
                    //translate([-1 * DEFAULT_THICKNESS, 0, BRACKET_Z - (ZIPTIE_Z + ZIPTIE_INSET_Z) + 0.5]) cube([BRACKET_X + (2 * DEFAULT_THICKNESS), ZIPTIE_Y, ZIPTIE_Z]);

                    
                    translate([(-1 * DEFAULT_THICKNESS) + 10, -10, ZIPTIE_INSET_Z - 0.5]) rotate([0, 0, 45]) cube([ZIPTIE_Y, WING_DEPTH, ZIPTIE_Z]);
                    translate([(-1 * DEFAULT_THICKNESS) + 10, -10, BRACKET_Z - (ZIPTIE_Z + ZIPTIE_INSET_Z) + 0.5]) rotate([0, 0, 45])  cube([ZIPTIE_Y, WING_DEPTH, ZIPTIE_Z]);
                   
                    #translate([(BRACKET_X + DEFAULT_THICKNESS) - ZIPTIE_Y - 10, -10, ZIPTIE_INSET_Z - 0.5]) rotate([0, 0, -45]) cube([ZIPTIE_Y, WING_DEPTH, ZIPTIE_Z]);
                    #translate([(BRACKET_X + DEFAULT_THICKNESS) - ZIPTIE_Y - 10, -10, BRACKET_Z - (ZIPTIE_Z + ZIPTIE_INSET_Z) + 0.5]) rotate([0, 0, -45]) cube([ZIPTIE_Y, WING_DEPTH, ZIPTIE_Z]);

                }
                
             }
         }
         translate([R, (-1 * Q), 0]) rotate([0, 0, WEDGE_ANGLE]) translate([0.5 * BOARD_X, 1.6 * Q, 0.5 * WEDGE_Z]) rotate([90, 0, 0]) union() {   
            cylinder(d=4, h=50, $fn=64);
            cylinder(d=12, h=Q, $fn=64);
         }
     }

    
    
}

wedge();
