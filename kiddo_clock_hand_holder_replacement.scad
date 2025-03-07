SHAFT_HEIGHT = 15;
SHAFT_DIAM = 8;
WASHER_DIAM = SHAFT_DIAM + 5;
WASHER_HEIGHT = 0.5;
SHAFT_HOLE_DIAM = 3.5;
DOME_HEIGHT = 8;
DOME_DIAM = 12;
DOME_SPHERE_PCT = 0.6;
SPHERE_RAW_HEIGHT = DOME_HEIGHT / DOME_SPHERE_PCT;

CUBE_HEIGHT = SPHERE_RAW_HEIGHT - DOME_HEIGHT;


module mushroom() {
        
    union() {
        // top
        translate([0, 0, (0.5 * SPHERE_RAW_HEIGHT) - CUBE_HEIGHT])
        difference() {
            SPHERE_XY_SCALE = DOME_DIAM / SPHERE_RAW_HEIGHT;
            scale([SPHERE_XY_SCALE, SPHERE_XY_SCALE, 1]) sphere(d=SPHERE_RAW_HEIGHT, $fn=64);
            translate([0, 0, (0.5 * CUBE_HEIGHT) - (0.5 * SPHERE_RAW_HEIGHT)]) {
                cube([DOME_DIAM, DOME_DIAM, CUBE_HEIGHT], center=true);
            }
        }

        translate([0, 0, -1 * SHAFT_HEIGHT]) difference() {
            cylinder(d=SHAFT_DIAM, h=SHAFT_HEIGHT, $fn=64);
            cylinder(d=SHAFT_HOLE_DIAM, h=SHAFT_HEIGHT, $fn=64);
        }
    }
}

module washer() {
    difference() { 
        cylinder(d=WASHER_DIAM, h=WASHER_HEIGHT, $fn=64);
        cylinder(d=1.05 * SHAFT_DIAM, h=WASHER_HEIGHT, $fn=64);
    }
}

translate([WASHER_DIAM, 0, 0]) washer();
mushroom();