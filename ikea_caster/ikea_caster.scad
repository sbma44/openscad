IKEA_WIDTH = 22.7;
CASTER_X = 33.2;
CASTER_Y = 39.2;
CASTER_Z = 1.7;
CASTER_BEARING_DIAM = 29;
CASTER_SCREW_DIAM = 4;
CASTER_SCREW_INSET = 4.5;
CASTER_Z_CLEARANCE = 5.7 - CASTER_Z;
THICKNESS = 2;

difference() {
    difference() {
        cube([CASTER_X + THICKNESS, CASTER_Y + THICKNESS, CASTER_Z + THICKNESS], center=true);
        cube([CASTER_X, CASTER_Y, CASTER_Z], center=true);

        for(x = [-1:2:1]) {
            for (y = [-1:2:1]) {
                translate([x * ((0.5 * CASTER_X) - CASTER_SCREW_INSET), y * ((0.5 * CASTER_Y) - CASTER_SCREW_INSET), 0]) cylinder(d=CASTER_SCREW_DIAM, h=(CASTER_Z + (2 * THICKNESS)), $fn=64, center=true);
            }
        }
    }
    cylinder(d=CASTER_BEARING_DIAM, h=(CASTER_Z + (THICKNESS * 2)), center=true, $fn=64);
}