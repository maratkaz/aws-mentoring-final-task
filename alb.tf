resource "aws_lb" "alb-test" {
  name               = "alb-test"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
}

resource "aws_lb_target_group" "ghost-ec2" {
  name     = "ghost-ec2"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id

  health_check {
    path = "/"
    port = 2368
    healthy_threshold = 2
    interval = 300
    timeout  = 120
    unhealthy_threshold = 10
    matcher = "200"
  }
}

resource "aws_lb_target_group" "ghost-fargate" {
  name     = "ghost-fargate"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb-test.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.ghost-ec2.arn
        weight = 50
      }

      target_group {
        arn    = aws_lb_target_group.ghost-fargate.arn
        weight = 50
      }

    }
  }
}
