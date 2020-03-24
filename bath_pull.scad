SQUARE_WIDTH=16;
DIAM=21.5;
DEPTH=22;
BUFFER=3;

union() {
    translate([0, 0, -1 * (BUFFER + (0.5 * DEPTH))]) rotate([180, 0, 0]) difference() {        
        difference() {
            difference() {
                cylinder(d=DIAM, h=DEPTH + (2*BUFFER), $fn=128, center=true);
                cube([SQUARE_WIDTH, 2 * SQUARE_WIDTH, DEPTH], center=true);
            }
            cylinder(d=(0.55*DIAM), h=DEPTH + BUFFER, $fn=128);
        }
        union() {
            translate([0, SQUARE_WIDTH - 1, 0]) cube([SQUARE_WIDTH, SQUARE_WIDTH, DEPTH + (BUFFER*2)], center=true);
            translate([0, (-1 * SQUARE_WIDTH) + 1, 0]) cube([SQUARE_WIDTH, SQUARE_WIDTH, DEPTH + (BUFFER*2)], center=true);
        }
    }
    
    translate([0, 0, 5]) rotate([90, 0, 0]) difference() {
        cylinder(d=16, h=5, center=true, $fn=128);
        cylinder(d=12, h=5, center=true, $fn=128);
    }
    
}