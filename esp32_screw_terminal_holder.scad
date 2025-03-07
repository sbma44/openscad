PCB_X = 63;
PCB_Z = 1.25;
PCB_Y = 22;
PCB_X_FUDGE = 2;

HOLE_DIAM = 3;

difference() {

    hull() {
        translate([-0.5 * PCB_Y, 0.5 * PCB_Y, 0]) cylinder(h=2 * PCB_Z, d=PCB_Y, $fn=64);
        translate([PCB_X + (0.5 * PCB_Y), 0.5 * PCB_Y, 0]) cylinder(h=2 * PCB_Z, d=PCB_Y, $fn=64);
    }
    translate([-0.5 * PCB_Y, 0.5 * PCB_Y, 0]) cylinder(h=2 * PCB_Z, d=HOLE_DIAM, $fn=64);
    translate([PCB_X + (0.5 * PCB_Y), 0.5 * PCB_Y, 0]) cylinder(h=2 * PCB_Z, d=HOLE_DIAM, $fn=64);
    translate([-0.5 * PCB_X_FUDGE, 0, PCB_Z]) cube([PCB_X + PCB_X_FUDGE, PCB_Y, PCB_Z]);
}

    
    