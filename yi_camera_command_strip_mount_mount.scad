DIAM_LOWER=4;
DIAM_UPPER=6;
WIDTH=2;
OFFSET_FROM_CENTER=11.5;
TRAY_DEPTH=3;
COMMAND_STRIP_Y=75;
COMMAND_STRIP_X=19;

module peg() {
    difference() {
        translate([0, 0, 2]) intersection() {
            union() {
                translate([0, 0, 1]) cylinder(r2=DIAM_LOWER/2, r1=(DIAM_LOWER+1)/2, h=1, $fn=64);
                cylinder(r1=DIAM_LOWER/2, r2=(DIAM_LOWER+1)/2, h=1, $fn=64);
                translate([0, 0, -1 * TRAY_DEPTH]) cylinder(r=DIAM_LOWER/2, h=TRAY_DEPTH, $fn=64);
            }
            cube([DIAM_LOWER+1, DIAM_LOWER, 2*WIDTH], center=true);
        }
        cube([1.5, 200, 200], center=true);
    }
}

union() {
    difference() {
        union() {
            for(f=[0:2]) {
                rotate([0, 0, 30 + (120 * f)]) translate([-1 * OFFSET_FROM_CENTER, 0, 0]) peg();
            }
            cylinder(r=OFFSET_FROM_CENTER + (DIAM_LOWER/2), h=1, $fn=128);
        }
        // this turns out to be pointless bc of command strip geom
        cylinder(r=OFFSET_FROM_CENTER - (DIAM_LOWER/2), h=1, $fn=128);
    }
    translate([0, 0, 0.5]) cube([COMMAND_STRIP_X, COMMAND_STRIP_Y,1], center=true);
}