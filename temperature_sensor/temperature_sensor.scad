box_size = [15.5, 40, 18];
wall_width = 0.8;
$fn = 36;

module box()
{
  /* Base */
  cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
  /* Walls */
  translate([wall_width, 0, wall_width]) cube([4, wall_width, box_size[2]]);
  translate([wall_width + 4, 0, wall_width]) cube([box_size[0] - 8, wall_width, 4]);
  translate([wall_width + 4 + box_size[0] - 8, 0, wall_width]) cube([4, wall_width, box_size[2]]);
  translate([wall_width, box_size[1] + wall_width, wall_width]) cube([box_size[0], wall_width, box_size[2]]);
  translate([0, 0, wall_width]) cube([wall_width, box_size[1] + (2 * wall_width), box_size[2]]);
  translate([box_size[0] + wall_width, 0, wall_width]) cube([wall_width, box_size[1] + (2 * wall_width), box_size[2]]);
}

module cover()
{
  /* Base */
  difference()
  {
    cube(box_size + [wall_width * 2, wall_width * 2, wall_width - box_size[2]]);
    translate([wall_width + 4, 0, 0]) cube([box_size[0] - 8, wall_width + 7, wall_width]);
  }
  /* Walls */
  translate([wall_width, wall_width, wall_width]) cube([4, wall_width, 1.5]);
  translate([4, wall_width, wall_width]) cube([wall_width, 7 + wall_width, 14.5]);
  translate([wall_width + 4, wall_width + 7, wall_width]) cube([box_size[0] - 8, wall_width, 14.5]);
  translate([wall_width + box_size[0] - 4, wall_width, wall_width]) cube([wall_width, 7 + wall_width, 14.5]);
  translate([wall_width + box_size[0] - 4, wall_width, wall_width]) cube([4, wall_width, 1.5]);
  translate([wall_width, box_size[1], wall_width]) cube([box_size[0], wall_width, 1.5]);
  translate([wall_width, wall_width, wall_width]) cube([wall_width, box_size[1] - wall_width,  1.5]);
  translate([box_size[0], wall_width, wall_width]) cube([wall_width, box_size[1] - wall_width,  1.5]);
}

box();
translate([30, 0, 0])
//color("red") translate([box_size[0] + 2 * wall_width, 0, 1.6 + box_size[2]]) rotate([0, 180, 0])
cover();
