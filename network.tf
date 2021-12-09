resource "aws_vpc" "cloudx" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  # main_route_table_id  = aws_route_table.cloudx_rt.id

  tags = {
    Name = "cloudx"
  }
}

resource "aws_route_table" "cloudx_rt" {
  vpc_id = aws_vpc.cloudx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "cloudx_rt"
  }
}

resource "aws_main_route_table_association" "cloudx_rt_igw" {
  vpc_id         = aws_vpc.cloudx.id
  route_table_id = aws_route_table.cloudx_rt.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.cloudx.id
}

resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.1.0/24"
  # availability_zone = "us-east-1a"
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.2.0/24"
  # availability_zone = "us-east-1b"
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.3.0/24"
  # availability_zone = "us-east-1c"
  availability_zone = var.availability_zones[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_c"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.10.0/24"
  # availability_zone = "us-east-1a"
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "private_a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.11.0/24"
  # availability_zone = "us-east-1b"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "private_b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.12.0/24"
  # availability_zone = "us-east-1c"
  availability_zone = var.availability_zones[2]

  tags = {
    Name = "private_c"
  }
}

resource "aws_subnet" "private_db_a" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.20.0/24"
  # availability_zone = "us-east-1a"
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "private_db_a"
  }
}

resource "aws_subnet" "private_db_b" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.21.0/24"
  # availability_zone = "us-east-1b"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "private_db_b"
  }
}

resource "aws_subnet" "private_db_c" {
  vpc_id     = aws_vpc.cloudx.id
  cidr_block = "10.10.22.0/24"
  # availability_zone = "us-east-1c"
  availability_zone = var.availability_zones[2]

  tags = {
    Name = "private_db_c"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cloudx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_subnet_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_subnet_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_subnet_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.cloudx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_rt_subnet_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_subnet_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_subnet_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_rt.id
}

