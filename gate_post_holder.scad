$fa=0.5;
$fp=1;

ROUND_POST_RADIUS = 6.5;
SQUARE_POST_WIDTH = 38.2;
CORNER_RADIUS = 2;
THICKNESS = 3;
POST_OFFSET = 3;

module rounded_square(post_width, corner_radius, inner=true) {
    union() {
        translate([0, corner_radius]) square([post_width, post_width - (corner_radius * 2)]);
        translate([corner_radius, 0]) square([post_width - (corner_radius * 2), post_width]);
        translate([corner_radius, corner_radius]) circle(r=corner_radius, $fn=36);
        translate([corner_radius, post_width - corner_radius]) circle(r=corner_radius, $fn=36);    
        if (inner) {
            translate([post_width - corner_radius, post_width - corner_radius]) circle(r=corner_radius, $fn=36);    
            translate([post_width - corner_radius, corner_radius]) circle(r=corner_radius, $fn=36);
        }
        else {
            translate([post_width - corner_radius, post_width - corner_radius]) square([corner_radius, corner_radius]);    
            translate([post_width - corner_radius, 0]) square([corner_radius, corner_radius]);
        }
    }
}

module footprint(thickness) {
    translate([-1 * thickness, -1 * thickness]) difference() {
    union() {
        translate([thickness, thickness]) difference() {
            translate([-1 * thickness, -1 * thickness]) rounded_square(SQUARE_POST_WIDTH + (2 * thickness), CORNER_RADIUS + thickness, false);
            rounded_square(SQUARE_POST_WIDTH, CORNER_RADIUS);
        }
        
        
        translate([ROUND_POST_RADIUS + POST_OFFSET + thickness + SQUARE_POST_WIDTH, thickness + (SQUARE_POST_WIDTH / 2)]) 
            difference() {
                difference() {
                    translate([(-1 * (SQUARE_POST_WIDTH/2)) + ROUND_POST_RADIUS + thickness, 0]) scale([1, 0.006 + (SQUARE_POST_WIDTH + (2 * thickness)) / SQUARE_POST_WIDTH]) circle(r=SQUARE_POST_WIDTH/2, $fn=36);
                    circle(r=ROUND_POST_RADIUS, $fn=36);
                }
                translate([-1 * (SQUARE_POST_WIDTH + ROUND_POST_RADIUS + thickness + POST_OFFSET), (-1 * thickness) + (-0.5 * SQUARE_POST_WIDTH)]) square([SQUARE_POST_WIDTH + (2*thickness), SQUARE_POST_WIDTH+ (2*thickness)]);
            }
        }
    translate([thickness + SQUARE_POST_WIDTH - POST_OFFSET, thickness - ROUND_POST_RADIUS + (0.5 * SQUARE_POST_WIDTH)]) square([2*ROUND_POST_RADIUS, 2*ROUND_POST_RADIUS]);
    }    
}

linear_extrude(10) footprint(THICKNESS);
translate([0, 0, 7.5]) linear_extrude(2.5) footprint(THICKNESS + 1);
translate([0, 0, 0]) linear_extrude(2.5) footprint(THICKNESS + 1);

