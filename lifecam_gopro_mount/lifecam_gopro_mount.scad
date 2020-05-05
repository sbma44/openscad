use <gopro_mounts_mooncactus.scad>

union() {
    import("files/camera_clip.STL");
    translate([-7, 11, 0]) rotate([180, 5, 0]) gopro_connector("double");
}