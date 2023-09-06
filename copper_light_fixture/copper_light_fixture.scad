// modular lightbulb socket LED mount

include <src/helix_extrude.scad>;

GLASS_BASE_HEIGHT=115;
BASE_OFFSET_HEIGHT=15;
ARMATURE_DIAM=67;
LED_GUTTER=10.5;
LEVEL_DIST=20;
BASE_HEIGHT=20;

module bulb_base() {
    intersection() {
        rotate([-90, 0, 0]) import("models/files/bulb_base_test.stl", convexity=10);
        rotate([-90, 0, 0]) cylinder(h=20, d=30, $fn=64);
    }
}

/*
module base() {
    difference() {
        union() {
            bulb_base();
            difference() {
                translate([0, 40, 0]) rotate([90, 0, 0]) cylinder(r=16, h=20, $fn=64);
                scale([1.02, 1, 1.02]) translate([0, 20, 0]) bulb_base();
            }
        }
        translate([0, 50, 0]) rotate([90, 0, 0]) cylinder(r=6, h=60, $fn=64);
    }
}
*/

module base() {
    translate([0, BASE_HEIGHT - BASE_OFFSET_HEIGHT, 0]) rotate([180, 0, 0]) bulb_base();
}

module support_ring() {
    
}

module flower_support() {
    union() {
        difference() {
            translate([0, (-1 * BASE_HEIGHT) - 2, 0]) rotate([90, 0, 0]) cylinder(d=ARMATURE_DIAM, h=3, $fn=64);
            for(q=[0 : 30 : 360]) {
                rotate([0, q, 0]) scale([3, 1, 0.5]) translate([15, (-1 * BASE_HEIGHT) - 2, 0]) rotate([90, 0, 0]) cylinder(d=ARMATURE_DIAM * 0.35, h=5, $fn=64);
            }
        }
        
        translate([0, -20, 0]) rotate([90, 0, 0]) difference() {
            cylinder(h=5, r=(ARMATURE_DIAM/2) + 1, $fn=64);
            cylinder(h=5, r=((ARMATURE_DIAM/2) + 1) - 2, $fn=64);
        }
    }
}

shape_pts = [
  [-1, 6.25],
  [-1, -6.25],
  [2, -6.25],
  [2, -5.25],
  [1, -5.25],
  [1, 5.25],
  [2, 5.25],
  [2, 6.25]
];

support_pts = [
  [0, 2.5],
  [-2.5, 0],
  [0, -2.5],
  [2.5, 0]
];


union() {
    rotate([90, 0, 0]) helix_extrude(shape_pts, 
        radius = ARMATURE_DIAM/2, 
        levels = round(GLASS_BASE_HEIGHT / LEVEL_DIST), 
        level_dist = LEVEL_DIST,
        vt_dir = "SPI_UP",
        $fn=64
    );
    
    base();
    translate([0, -15, 0]) rotate([90, 0, 0]) cylinder(h=10, d=25, $fn=64);                    
    
    flower_support();
    
    offsets = [1000, 115, 115, 120, 125, 130];
    offsets2 = [1000, -10, -5, 0, 0, 0];
    rotate([90, 0, 0]) difference() {
        translate([0, 0, -6]) cylinder(h=GLASS_BASE_HEIGHT + 17, r=(ARMATURE_DIAM/2) + 1, $fn=64);
        translate([0, 0, -6]) cylinder(h=GLASS_BASE_HEIGHT + 17, r=((ARMATURE_DIAM/2) + 1) - 2, $fn=64);
        for(q=[0:60:360]) {
            rotate([0, 0, q]) {
                cube([26, 100, 3 * GLASS_BASE_HEIGHT], center=true);
                translate([(ARMATURE_DIAM/2) + 1, 0, offsets[q/60]]) cube(ARMATURE_DIAM * 0.4, center=true);
                translate([(ARMATURE_DIAM/2) + 1, 0, offsets2[q/60]]) cube(ARMATURE_DIAM * 0.4, center=true);

            }

        }
    }

}