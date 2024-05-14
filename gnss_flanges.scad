GLAND_DIAM = 16;
ELECTRICAL_DIAM = 20;
FLANGE_LIP = 4;
DATA_DIAM = 28;
FLANGE_THICKNESS = 3.5;
THREADED_EXTENSION_HEIGHT=10;
NURL_WIDTH = 4;

GLAND_THREAD_DIAM = 16;
THREAD_PITCH = 1.2;

include <threads.scad>

module electrical() {
    difference() {
        union() {
            cylinder(h=FLANGE_THICKNESS, d=ELECTRICAL_DIAM + FLANGE_LIP, $fn=64);
            translate([0, 0, FLANGE_THICKNESS]) metric_thread(diameter=ELECTRICAL_DIAM, pitch=THREAD_PITCH, length=FLANGE_THICKNESS + THREADED_EXTENSION_HEIGHT);
        }
        #union() {
            translate([0, 0, FLANGE_THICKNESS + THREADED_EXTENSION_HEIGHT]) metric_thread(diameter=GLAND_THREAD_DIAM, pitch=THREAD_PITCH, length=FLANGE_THICKNESS, internal=true);
            cylinder(h=THREADED_EXTENSION_HEIGHT + FLANGE_THICKNESS, d=GLAND_THREAD_DIAM + 1, $fn=64);
        }
    }
}

module electrical_nut() {
    difference() {
        union() {
            cylinder(h=FLANGE_THICKNESS, d=ELECTRICAL_DIAM + FLANGE_LIP, $fn=64);
            for(r=[0: 30: 360]) {
                rotate([0, 0, r]) translate([(-0.5 * NURL_WIDTH) + ELECTRICAL_DIAM * 0.5, -0.5 * NURL_WIDTH, 0]) cube([1.2*NURL_WIDTH, NURL_WIDTH, FLANGE_THICKNESS]);
            }
        }
        metric_thread(diameter=ELECTRICAL_DIAM + 1, pitch=THREAD_PITCH, length=FLANGE_THICKNESS + THREADED_EXTENSION_HEIGHT, internal=true);
    }
}


module data() {
    difference() {
        union() {
            cylinder(h=FLANGE_THICKNESS, d=DATA_DIAM + FLANGE_LIP, $fn=64);
            translate([0, 0, FLANGE_THICKNESS]) metric_thread(diameter=DATA_DIAM, pitch=THREAD_PITCH, length=FLANGE_THICKNESS + THREADED_EXTENSION_HEIGHT);
        }
        #union() {
            translate([0, 0, FLANGE_THICKNESS + THREADED_EXTENSION_HEIGHT]) metric_thread(diameter=GLAND_THREAD_DIAM, pitch=THREAD_PITCH, length=FLANGE_THICKNESS, internal=true);
            cylinder(h=THREADED_EXTENSION_HEIGHT + FLANGE_THICKNESS, d=GLAND_THREAD_DIAM + 1, $fn=64);
        }
    }
}

module data_nut() {
    difference() {
        union() {
            cylinder(h=FLANGE_THICKNESS, d=DATA_DIAM + FLANGE_LIP, $fn=64);
            for(r=[0: 30: 360]) {
                rotate([0, 0, r]) translate([(-0.5 * NURL_WIDTH) + DATA_DIAM * 0.5, -0.5 * NURL_WIDTH, 0]) cube([1.2*NURL_WIDTH, NURL_WIDTH, FLANGE_THICKNESS]);
            }
        }
        metric_thread(diameter=DATA_DIAM + 1, pitch=THREAD_PITCH, length=FLANGE_THICKNESS + THREADED_EXTENSION_HEIGHT, internal=true);
    }
}

module thread_test(gland_diameter=16, pitch=1) {
    difference() {
       cylinder(h=FLANGE_THICKNESS, d=gland_diameter + (2*FLANGE_LIP), $fn=64); 
       metric_thread(diameter=gland_diameter, pitch=pitch, length=FLANGE_THICKNESS, internal=true);
       translate([0, 0.5 * (gland_diameter + (0.5 * FLANGE_LIP)) + 0.5, FLANGE_THICKNESS - 0.5]) linear_extrude(5) text(str(gland_diameter), 0.8 * FLANGE_LIP, "Arial Rounded MT Bold:style=Regular", halign="center", valign="center");
       translate([0, - 0.5 * (gland_diameter + (0.5 * FLANGE_LIP)) - 1.0, FLANGE_THICKNESS - 0.5]) rotate([0, 0, 180]) linear_extrude(5) text(str(pitch), 0.8 * FLANGE_LIP, "Arial Rounded MT Bold:style=Regular", halign="center", valign="center");        
    }

}

module thread_array() {
    translate([0, 16 + (2*FLANGE_LIP) + 5, 0]) {
        thread_test(16, 1);
        translate([16 + (2*FLANGE_LIP) + 5, 0, 0]) thread_test(16, 1.1);
        translate([-1 * (16 + (2*FLANGE_LIP) + 5), 0, 0]) thread_test(16, 1.2);
    }

    thread_test(17, 1);
    translate([17 + (2*FLANGE_LIP) + 5, 0, 0]) thread_test(17, 1.1);
    translate([-1 * (17 + (2*FLANGE_LIP) + 5), 0, 0]) thread_test(17, 1.2);

    translate([0, -1 * ((18 + (2*FLANGE_LIP)) + 5), 0]) {
        thread_test(18, 1);
        translate([18 + ((2*FLANGE_LIP) + 5), 0, 0]) thread_test(18, 1.1);
        translate([-1 * ((18 + (2*FLANGE_LIP) + 5)), 0, 0]) thread_test(18, 1.2);
    }
}

electrical();
translate([ELECTRICAL_DIAM + FLANGE_LIP + 5, 0, 0]) electrical_nut();

/*
translate([0, 50, 0]) {
    data();
    translate([ELECTRICAL_DIAM + FLANGE_LIP + 12, 0, 0]) data_nut();
}
*/

