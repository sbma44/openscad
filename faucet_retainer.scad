INNER_CYLINDER_DIAM = 15;
INNER_CYLINDER_HEIGHT = 30;
HOSE_DIAM = 10;
PADDING = 2;

ZIPTIE_CHANNEL_HEIGHT = 8;
ZIPTIE_CHANNEL_BORDER = 2;

difference() {
    span = INNER_CYLINDER_DIAM + (2*PADDING);
    union() {
        cylinder(h=INNER_CYLINDER_HEIGHT + (2*PADDING), d=span, $fn=128);
        translate([0, 0, 3]) cylinder(h=ZIPTIE_CHANNEL_BORDER, d=span + 1, $fn=128);
        translate([0, 0, 3 + ZIPTIE_CHANNEL_HEIGHT]) cylinder(h=ZIPTIE_CHANNEL_BORDER, d=span + 1, $fn=128);
        
        translate([0, 0, INNER_CYLINDER_HEIGHT - 3]) cylinder(h=ZIPTIE_CHANNEL_BORDER, d=span + 1, $fn=128);
        translate([0, 0, INNER_CYLINDER_HEIGHT - (3 + ZIPTIE_CHANNEL_HEIGHT)]) cylinder(h=ZIPTIE_CHANNEL_BORDER, d=span + 1, $fn=128);

    }
    translate([0, 0, PADDING]) cylinder(h=INNER_CYLINDER_HEIGHT, d=INNER_CYLINDER_DIAM, $fn=128);
    cylinder(h=INNER_CYLINDER_HEIGHT + (2*PADDING), d=HOSE_DIAM, $fn=128);
    translate([-0.5 * (span+2), 0, 0]) cube([span + 2, span + 2, INNER_CYLINDER_HEIGHT + (2*PADDING)]);
}
