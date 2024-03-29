resource "aws_autoscaling_group" "ghost_ec2_pool" {
#   availability_zones = var.availability_zones
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.ghost.id
    version = "$Latest"
  }

  depends_on           = [aws_launch_template.ghost]
  vpc_zone_identifier  = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
}

resource "aws_autoscaling_attachment" "asg_attachment_ghost-ec2" {
  autoscaling_group_name = aws_autoscaling_group.ghost_ec2_pool.id
  alb_target_group_arn   = aws_lb_target_group.ghost-ec2.arn
}