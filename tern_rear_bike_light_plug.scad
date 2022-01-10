TUBE_INNER_DIAM = 17.5;
FIN = 1;
INNER_ROD_DIAM = 8.6 + 1;
OUTER_ROD_DIAM = 15.5 + 0.5; // (0.5 fudge)
DEPTH = 3;
TOTAL_DEPTH = 20;
DEPTH_OFFSET = 2;


module main() {
    difference() {
        cylinder(h=TOTAL_DEPTH, r1=TUBE_INNER_DIAM * 0.5, r2=(TUBE_INNER_DIAM-1) * 0.5, $fn=64);
        translate([0, -1 * TUBE_INNER_DIAM, 0]) cube([TUBE_INNER_DIAM * 2, TUBE_INNER_DIAM * 2, TOTAL_DEPTH]); 
        cylinder(h=TOTAL_DEPTH, d=INNER_ROD_DIAM, $fn=64);
        translate([0, 0, DEPTH]) cylinder(h=DEPTH_OFFSET, d=OUTER_ROD_DIAM, $fn=128);
    }
}

module fins() {
    difference() {
        intersection() {
            cylinder(h=TOTAL_DEPTH, d=TUBE_INNER_DIAM, $fn=64);
            STEPS = 3;
            for(i=[0:1:3]) {
                rotate([0, 0, i * (360 / STEPS)]) translate([0, 0, 0.5 * TOTAL_DEPTH]) cube([TUBE_INNER_DIAM, FIN, TOTAL_DEPTH], center=true);
            }
        }
        cylinder(h=TOTAL_DEPTH, d=OUTER_ROD_DIAM, $fn=64);
        translate([0, -1 * TUBE_INNER_DIAM, 0]) cube([TUBE_INNER_DIAM * 2, TUBE_INNER_DIAM * 2, TOTAL_DEPTH]); 
    }
}

union() {
    main();
    fins();
}