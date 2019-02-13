box_size = [32, 37, 20];
wall_width = 0.8;
bottom_height = 6;
$fn = 36;

module tab()
{
  translate([0, 1, 0]) rotate([90, 0, 0]) linear_extrude(height = 1) polygon([[0, 0], [0, 2], [wall_width, 2]]);
  translate([0, 5, 0]) rotate([90, 0, 0]) linear_extrude(height = 1) polygon([[0, 0], [0, 2], [wall_width, 2]]);
  translate([0, 0, 2]) cube([wall_width, 1, 2]);
  translate([0, 4, 2]) cube([wall_width, 1, 2]);
  translate([0, 0, 4]) cube([wall_width, 5, 1]);
}

module bulge()
{
   rotate([-90, 0, 0]) linear_extrude(height = 3) polygon([[0, 0], [0, 2], [wall_width, 2]]);
}

module box()
{
  /* Base */
  cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
  /* Walls */
  translate([wall_width, 0, wall_width]) cube([7.5, wall_width, bottom_height]);
  translate([7.5 + wall_width, 0, wall_width]) cube([box_size[0] - 7.5, wall_width, 4]);
  translate([wall_width, box_size[1] + wall_width, wall_width]) cube([box_size[0], wall_width, bottom_height]);
  translate([0, 0, wall_width]) cube([wall_width, box_size[1] + (2 * wall_width), bottom_height]);
  translate([box_size[0] + wall_width, 0, wall_width]) cube([wall_width, box_size[1] + (2 * wall_width), bottom_height]);
  /* Tabs */
  translate([wall_width + 6, wall_width, wall_width + 4]) rotate([0, 0, 90]) tab();
  translate([wall_width, wall_width + 19, wall_width + 4]) tab();
  translate([wall_width + box_size[0], wall_width + 24, wall_width + 4]) rotate([0, 0, -180]) tab();
}

module cover()
{
  difference()
  {
    union()
    {
      /* Base */
      cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
      /* Walls */
      translate([box_size[0] - 7.5 + wall_width, 0, wall_width]) cube([7.5, wall_width, box_size[2] - bottom_height]);
      translate([wall_width, 0, wall_width]) cube([box_size[0] - 7.5, wall_width, box_size[2] - bottom_height - 3]);
      translate([wall_width, box_size[1] + wall_width, wall_width]) cube([box_size[0], wall_width,  box_size[2] - bottom_height]);
      translate([0, 0, wall_width]) cube([wall_width, box_size[1] + (wall_width * 2),  box_size[2] - bottom_height]);
      translate([box_size[0] + wall_width, 0, wall_width]) cube([wall_width, box_size[1] + (wall_width * 2),  box_size[2] - bottom_height]);
    }
    /* Terminals cut-out */
    cube([box_size[0] - 7.5 + wall_width, 8, wall_width + 5]);
  }
  /* Extra walls */
  //translate([wall_width, 7, wall_width]) cube([27, wall_width, 5.5]);
  //translate([27, wall_width, wall_width]) cube([wall_width, 7, 15.5]);
  //cube([27, 7, wall_width + 3]);
  translate([wall_width, wall_width + 20, wall_width + box_size[2] - bottom_height]) bulge();
  translate([wall_width + box_size[0], wall_width + 23, wall_width + box_size[2] - bottom_height]) rotate([0, 0, -180]) bulge();
  translate([3 + wall_width + box_size[0] - 5, wall_width, wall_width + box_size[2] - bottom_height]) rotate([0, 0, 90]) bulge();
  difference()
  {
    translate([wall_width, wall_width, wall_width + 5]) cube([box_size[0] - 7.5, 8 - wall_width, wall_width]);
    translate([wall_width + 3.5, wall_width + 3.5, wall_width + 5]) cylinder(r = 1.5, h = wall_width);
    translate([wall_width + 8.5, wall_width + 3.5, wall_width + 5]) cylinder(r = 1.5, h = wall_width);
    translate([wall_width + 13.5, wall_width + 3.5, wall_width + 5]) cylinder(r = 1.5, h = wall_width);
    translate([wall_width + 19, wall_width + 3.5, wall_width + 5]) cylinder(r = 1, h = wall_width);
    translate([wall_width + 22.5, wall_width + 3.5, wall_width + 5]) cylinder(r = 1, h = wall_width);
  }
  translate([wall_width, 8, wall_width]) cube([box_size[0] - 7.5, wall_width, 5 + wall_width]);
  translate([wall_width + box_size[0] - 7.5, wall_width, wall_width]) cube([wall_width, 8, 5 + wall_width]);
  //translate([wall_width + 24.5, 0, 10])
  //translate([wall_width + 24.5, 5, 6])
  //rotate([90, 180, 0]) linear_extrude(0.5) text("S1 S2 OUT  L    C", size = 2);
}

box();
translate([50, 0, 0])
//translate([box_size[0] + wall_width * 2, 0, box_size[2] + wall_width * 2]) rotate([0, 180, 0])
cover();
