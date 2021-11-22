resource "aws_security_group" "ec2_pool" {
  name        = "ec2_pool"
  description = "allows access for ec2 instances"
  vpc_id      = aws_vpc.cloudx.id
  depends_on = [aws_security_group.alb]

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
  }

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.cloudx.cidr_block]
  }

  ingress {
    from_port        = 2368
    to_port          = 2368
    protocol         = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ec2_pool"
  }
}

resource "aws_security_group" "fargate_pool" {
  name        = "fargate_pool"
  description = "allows access for fargate instances"
  vpc_id      = aws_vpc.cloudx.id
  depends_on = [aws_security_group.alb]

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.cloudx.cidr_block]
  }

  ingress {
    from_port        = 2368
    to_port          = 2368
    protocol         = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "fargate_pool"
  }
}

resource "aws_security_group" "mysql" {
  name        = "mysql"
  description = "defines access to ghost db"
  vpc_id      = aws_vpc.cloudx.id
  depends_on = [aws_security_group.ec2_pool, aws_security_group.fargate_pool]

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.fargate_pool.id]
  }

  tags = {
    Name = "mysql"
  }
}

resource "aws_security_group" "efs" {
  name        = "efs"
  description = "defines access to efs mount points"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups = [aws_security_group.fargate_pool.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "efs"
  }
}

resource "aws_security_group_rule" "alb_ec2_rule" {
  security_group_id        = aws_security_group.alb.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  type                     = "egress"
  source_security_group_id = aws_security_group.ec2_pool.id
}

resource "aws_security_group_rule" "alb_fargate_rule" {
  security_group_id        = aws_security_group.alb.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  type                     = "egress"
  source_security_group_id = aws_security_group.fargate_pool.id
}

resource "aws_security_group" "alb" {
  name        = "alb"
  description = "defines access to alb"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
  }

  tags = {
    Name = "alb"
  }
}

resource "aws_security_group" "vpc_endpoint" {
  name        = "vpc_endpoint"
  description = "defines access to vpc endpoints"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    description      = "defines access to vpc endpoints"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.cloudx.cidr_block]
  }

  tags = {
    Name = "vpc_endpoint"
  }
}