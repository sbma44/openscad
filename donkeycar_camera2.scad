$fa=0.5;
$fp=1;

union() {
    translate([-17, 7, -3]) linear_extrude(3) difference() {
        polygon(points=[[0,0], [0, -14], [34, -14], [34,0], [27,113], [7,114], [0,0]]);
        translate([17,6,0]) circle(r=1.5, $fn=32);
        translate([17,16,0]) circle(r=1.5, $fn=32);
        translate([0, 21]) square(500);
        }
    translate([0,0.35,10]) rotate([-90, 0, 0]) import("gpm_triple_naked.stl");
}

//