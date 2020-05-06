THICKNESS=2.5;
OFFSET_FROM_CENTER=12.5;
HOLE_DIAM=4;

DETENTS = 36;
DEGREES_PER_DETENT = 360 / DETENTS;
DIAM = 30;
INSET_DIAM = 20;
RADIUS = DIAM / 2;
HEIGHT = 3;
DETENT_DEPTH = 1;


module top() {
    difference() {
        cylinder(r=OFFSET_FROM_CENTER + HOLE_DIAM + THICKNESS, h=THICKNESS, $fn=128);
        for(i=[0:2]) {
            rotate([0, 0, 120*i]) translate([OFFSET_FROM_CENTER, 0, 0]) cylinder(d=HOLE_DIAM, h=THICKNESS, $fn=128);
        }
    }
}


module detent_wheel(support=1.0) {
    x = 0;
    r = RADIUS * 1.1;
    difference() {
        union() {
            difference() {
                translate([0, 0, -1 * HEIGHT]) cylinder(d=DIAM, h=HEIGHT, $fn=128);
                for(x=[0:DEGREES_PER_DETENT:360]) {
                    polyhedron(points=[[0,0,0], [r * cos(x), r * sin(x), 0], [r * cos(x + DEGREES_PER_DETENT), r * sin(x + DEGREES_PER_DETENT), 0], [r * cos(x + (0.5 * DEGREES_PER_DETENT)), r * sin(x + (0.5 * DEGREES_PER_DETENT)), -1 * DETENT_DEPTH], [0, 0, -1 * DETENT_DEPTH]], 
                        faces=[[2, 1, 0], [1, 3, 0], [2, 3, 1], [0, 3, 2]], convexity=10);
                }
                translate([0, 0, -1 * DETENT_DEPTH])cylinder(d=INSET_DIAM, h=DETENT_DEPTH, $fn=128);    
            }
            if(support > 0) {
                translate([-1 * RADIUS, -1 * support * RADIUS, -1 * HEIGHT]) cube([RADIUS, support * DIAM, HEIGHT - DETENT_DEPTH]);
            }
        }
        translate([0, 0, -1 * HEIGHT]) cylinder(d=HOLE_DIAM, h=HEIGHT, $fn=128);
    }
}

module unit_a() {
    union() {
        translate([(DIAM * -0.5) - THICKNESS, 0, 0]) rotate([180, 0, 0]) rotate([0, 90, 0]) top();
        translate([0, 0, 0.5 * HEIGHT]) detent_wheel();
        intersection() {
            union() {
                translate([-1.75 * RADIUS, RADIUS - (HEIGHT - DETENT_DEPTH), 0]) rotate([0, 45, 0]) cube([RADIUS, HEIGHT - DETENT_DEPTH, RADIUS]);
                translate([-1.75 * RADIUS, (-1 * RADIUS), 0]) rotate([0, 45, 0]) cube([RADIUS, HEIGHT - DETENT_DEPTH, RADIUS]);
            }
            translate([-1 * RADIUS, -50, -100]) cube([100, 100, 100]);
        }
    }
}

module unit_b() {
    color("cyan") translate([0, 0, 10]) rotate([180, 0, 120]) union() {
        detent_wheel(support=0.9);
        rotate([0, -90, 0]) translate([-0.5 * RADIUS, 0, RADIUS + HEIGHT]) detent_wheel(support=0);
            intersection() {
                union() {
                    translate([-1.75 * RADIUS, (0.9 * RADIUS) - (HEIGHT - DETENT_DEPTH), 0]) rotate([0, 45, 0]) cube([RADIUS, HEIGHT - DETENT_DEPTH, RADIUS]);
                    translate([-1.75 * RADIUS, (-0.9 * RADIUS), 0]) rotate([0, 45, 0]) cube([RADIUS, HEIGHT - DETENT_DEPTH, RADIUS]);
                }
                translate([-1 * RADIUS, -50, -100 - DETENT_DEPTH]) cube([100, 100, 100]);
         }
    }
}

BOX_X = 64;
BOX_Y = 34;
BOX_Z = 22;

CONE_DIAM = 11;
USB_X_OFFSET = 11;
USB_Y = 8;
USB_Z = 3;

cube([BOX_X, BOX_Y, BOX_Z]);
//unit_a();