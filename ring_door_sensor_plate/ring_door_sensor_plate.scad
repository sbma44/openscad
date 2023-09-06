//translate([35, 10, 0]) cube([8.4, 8.4, 3]);

/*
union() {
    difference() {
        translate([15, 10, 0]) cube([25, 13, 5]);
        linear_extrude(height=5) scale([0.096, 0.096, 1.0]) import("door_trim_profile.svg");
    }
    FONTSCALE = 0.2;
    translate([33, 20, 5]) scale([FONTSCALE, FONTSCALE, 1.0]) linear_extrude(height=0.5) text("0.096");

}
*/

s = 0.090;
HEIGHT = 53;
MOUNTING_HOLE_SEPARATION = 33;
MOUNTING_HOLE_DIAM = 3.5;
MOUNTING_HOLE_INSET = 5;
UNIT_HEIGHT = 22;
ROUNDED_CUBE_CYLINDER_DIAM = 12;

module test(s, label) {
    union() {
        difference() {
            translate([15, 10, 0]) cube([25, 13, 5]);
            linear_extrude(height=5) scale([s, s, 1.0]) import("door_trim_profile.svg");
        }
        FONTSCALE = 0.4;
        translate([33.9, 18, 5]) scale([FONTSCALE, FONTSCALE, 1.0]) linear_extrude(height=1) text(str(label));

    }
}

module rounded_cube() {
    union() {
        translate([21, 0, 6]) rotate([-90, 0, 0]) cylinder(d=ROUNDED_CUBE_CYLINDER_DIAM, h=100, $fn=64);
        translate([21, 0, HEIGHT - 6]) rotate([-90, 0, 0]) cylinder(d=ROUNDED_CUBE_CYLINDER_DIAM, h=100, $fn=64);
        translate([21, 0, 0]) cube([25 - 6, 100, HEIGHT]);
        translate([15, 0, 6]) cube([25 - 6, 100, HEIGHT - ROUNDED_CUBE_CYLINDER_DIAM]);
    }
}

module sensor_trim_mount() {
    difference() {
        translate([-15, -11, 0]) union() {
            intersection() {
                difference() {
                    translate([15, 10, 0]) cube([UNIT_HEIGHT, 13, HEIGHT]);
                    linear_extrude(height=HEIGHT) scale([s, s, 1.0]) import("door_trim_profile.svg");

                }
                rounded_cube();
            }
        }
        
        
        // bottom
        hull() {
            translate([UNIT_HEIGHT - MOUNTING_HOLE_INSET, 0, (HEIGHT - MOUNTING_HOLE_SEPARATION) / 2.0]) rotate([-90, 0, 0]) cylinder(h=13, d=MOUNTING_HOLE_DIAM, $fn=64);
            translate([MOUNTING_HOLE_INSET, 0, (HEIGHT - MOUNTING_HOLE_SEPARATION) / 2.0]) rotate([-90, 0, 0]) cylinder(h=13, d=MOUNTING_HOLE_DIAM, $fn=64);
        }

        // top        
        hull() {
            translate([UNIT_HEIGHT - MOUNTING_HOLE_INSET, 0, ((HEIGHT - MOUNTING_HOLE_SEPARATION) / 2.0) + MOUNTING_HOLE_SEPARATION]) rotate([-90, 0, 0]) cylinder(h=13, d=MOUNTING_HOLE_DIAM, $fn=64);
            translate([MOUNTING_HOLE_INSET, 0, ((HEIGHT - MOUNTING_HOLE_SEPARATION) / 2.0) + MOUNTING_HOLE_SEPARATION]) rotate([-90, 0, 0]) cylinder(h=13, d=MOUNTING_HOLE_DIAM, $fn=64);
        }
    }
}

module magnet_platform() {
    PLATFORM_X = 11;
    PLATFORM_Y = 12;
    PLATFORM_Z = 53;
    intersection() {
        translate([-21 + (0.5 * ROUNDED_CUBE_CYLINDER_DIAM), 0, 0]) rounded_cube();
        cube([PLATFORM_X, PLATFORM_Y, PLATFORM_Z]);
    }
}

//sensor_trim_mount();
magnet_platform();