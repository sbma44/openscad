PROTRUSION_LENGTH=8;
DIAM=4.2 * 1.0;
NUT_DIAM=8.5;

difference() {
    CYLINDER_LENGTH = PROTRUSION_LENGTH - (0.5 * NUT_DIAM) + (0.5 * (NUT_DIAM - DIAM));
    union() {
        cylinder(d=NUT_DIAM, h=CYLINDER_LENGTH, $fn=64);
        translate([0, 0, CYLINDER_LENGTH]) sphere(d=NUT_DIAM, $fn=64);
    }
    cylinder(d=DIAM, h=PROTRUSION_LENGTH, $fn=64);
}