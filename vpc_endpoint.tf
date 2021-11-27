resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint.id,
  ]
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint.id,
  ]
}

resource "aws_vpc_endpoint" "ecr" {
  vpc_id       = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint.id,
  ]
}

resource "aws_vpc_endpoint" "efs" {
  vpc_id       = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.elasticfilesystem"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint.id,
  ]
}

resource "aws_vpc_endpoint" "events" {
  vpc_id       = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.events"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint.id,
  ]
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id       = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoint.id,
  ]
}
