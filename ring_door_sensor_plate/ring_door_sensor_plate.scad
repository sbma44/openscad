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

module real_deal() {
    s = 0.090;
    HEIGHT = 53;
    MOUNTING_HOLE_SEPARATION = 33;
    MOUNTING_HOLE_DIAM = 3.5;
    MOUNTING_HOLE_INSET = 5;
    UNIT_HEIGHT = 25;
    
    difference() {
        translate([-15, -11, 0]) union() {
            intersection() {
                difference() {
                    translate([15, 10, 0]) cube([UNIT_HEIGHT, 13, HEIGHT]);
                    linear_extrude(height=HEIGHT) scale([s, s, 1.0]) import("door_trim_profile.svg");

                }
                union() {
                    translate([21, 0, 6]) rotate([-90, 0, 0]) cylinder(d=12, h=100, $fn=64);
                    translate([21, 0, HEIGHT - 6]) rotate([-90, 0, 0]) cylinder(d=12, h=100, $fn=64);
                    translate([21, 0, 0]) cube([25 - 6, 100, HEIGHT]);
                    translate([15, 0, 6]) cube([25 - 6, 100, HEIGHT - 12]);
                }
            }
        }
        translate([UNIT_HEIGHT - MOUNTING_HOLE_INSET, 0, (HEIGHT - MOUNTING_HOLE_SEPARATION) / 2.0]) {
            rotate([-90, 0, 0]) cylinder(h=13, d=MOUNTING_HOLE_DIAM, $fn=64);
            translate([0, 0, MOUNTING_HOLE_SEPARATION]) rotate([-90, 0, 0]) cylinder(h=13, d=MOUNTING_HOLE_DIAM, $fn=64);
        }
    }
}
//test(0.092, "92");
//translate([0, 20, 0]) test(0.091, "91");
//translate([0, 40, 0]) test(0.090, "90");
real_deal();