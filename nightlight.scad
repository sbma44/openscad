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

WEMOS_Y = 26;

CONE_DIAM_A = 11;
CONE_X = 20;
CONE_DIAM_B = 6.5;
USB_Y_OFFSET = 11;
USB_X = 6;
USB_Y = 8;
USB_Z = 3;

BUTTON_DIAM = 12;
BUTTON_Y = 21;
BUTTON_X = 26.6;
BUTTON_Z_CLEARANCE = 9.9;
BUTTON_X_INSET = 17.6;

BUTTON_HOLE_INSET = 2.8;
SCREW_INNER_DIAM = 2.2;
SCREW_OUTER_DIAM = 3.1;
SCREW_HOLE_DIAM = (SCREW_INNER_DIAM + SCREW_OUTER_DIAM) / 2;

module screw_anchor(h) {
    difference() {
        cylinder(d=SCREW_HOLE_DIAM + 2, h=h, $fn=64);
        cylinder(d=SCREW_HOLE_DIAM, h=h, $fn=64);
    }
}



DEBUG = 1;
if (DEBUG > 0) {
    //#color([100, 100, 0, 0.3]) cube([BOX_X, BOX_Y, BOX_Z]);
    // wemos
    color([0, 0, 100]) translate([BOX_X - 34, 2, BOX_Z - USB_Z]) cube([34, WEMOS_Y, 1.2]); 
    // perfboard
    difference() {
        color([100, 100, 0]) translate([BOX_X - 31 - 7, 0, BOX_Z - USB_Z - 10.5]) cube([31, BOX_Y, 1.5]); 
        translate([(BOX_X - 31 - 7 + 3.7), BOX_Y - 3.7, 0]) cylinder(d=3.3, h=20, $fn=64);
    }
    // usb connector
    color("gray") translate([BOX_X - USB_X, 2 + (0.5 * WEMOS_Y) - (0.5 * USB_Y), BOX_Z - USB_Z]) cube([USB_X, USB_Y, USB_Z]);
    // cone
    color("gray") translate([CONE_X, 0.5 * BOX_Y, BOX_Z - USB_Z - 7.5]) rotate([0, -90, 0]) cylinder(r1=CONE_DIAM_B * 0.5, r2=CONE_DIAM_A * 0.5, h=CONE_X, $fn=128);
    
    // button
    translate([CONE_X, 0.5 * (BOX_Y - BUTTON_Y), -1 * BUTTON_Z_CLEARANCE]) {
        #cube([BUTTON_X, BUTTON_Y, BUTTON_Z_CLEARANCE]);
        translate([BUTTON_X_INSET, BUTTON_Y / 2, -4]) cylinder(d=BUTTON_DIAM, h=4, $fn=64);
        ANCHOR_HEIGHT=20;
        translate([BUTTON_HOLE_INSET, BUTTON_HOLE_INSET, BUTTON_Z_CLEARANCE]) screw_anchor(ANCHOR_HEIGHT);
        translate([BUTTON_HOLE_INSET, BUTTON_Y - BUTTON_HOLE_INSET, BUTTON_Z_CLEARANCE]) screw_anchor(ANCHOR_HEIGHT);
    }
}

module case() {
    hull() {
        for(z=[0:1]) {
            for(y=[0:1]) {
                for(x=[0:1]) {
                    translate([x == 1 ? BOX_X : BOX_X - 31 - 7 , y * BOX_Y, z * BOX_Z]) sphere(r=3, $fn=128);
                }
            }
        }
        TORUS_WIDTH = 1;
        translate([0, 0.5 * BOX_Y, BOX_Z - USB_Z - 7.5]) rotate([0, 90, 0]) rotate_extrude() translate([(CONE_DIAM_A * 0.5) + TORUS_WIDTH, 0, 0]) circle(r=TORUS_WIDTH, $fn=32);
    }
}

#union() {    
    difference() {
        case();
        translate([-10, -10, BOX_Z * 0.5]) cube([100, 100, 50]);
        translate([1.5, 3, 3]) resize([BOX_X, BOX_Y, BOX_Z]) case();
        translate([-5, 0.5 * BOX_Y, BOX_Z - USB_Z - 7.5]) rotate([0, 90, 0]) cylinder(d=CONE_DIAM_A, h=20, $fn=64);   
    }
    difference() {
            intersection() {
            translate([10, 0, 0]) cube([1, BOX_Y, BOX_Z]);
            translate([1.5, 3, 3]) resize([BOX_X, BOX_Y, BOX_Z]) case();
        }
        color("gray") translate([CONE_X, 0.5 * BOX_Y, BOX_Z - USB_Z - 7.5]) rotate([0, -90, 0]) cylinder(r1=CONE_DIAM_B * 0.5, r2=CONE_DIAM_A * 0.5, h=CONE_X, $fn=128);
        translate([-10, -10, BOX_Z * 0.5]) cube([100, 100, 50]);
    }
}

//unit_a(); 