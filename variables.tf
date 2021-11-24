variable "my_ip" {
  default = "2.57.96.186/32"
}

variable "key_pair" {
  default = "ec2-virginia"
}

variable "db_pass" {
  default = "foobarbaz"
}

variable "availability_zones" {
  description = "List of availability zones"
  type = list
  default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}

locals {
  ecr = {
    aws_account_id = "443141460384"
    aws_region = "es-east-1"
    docker_source = "ghost:latest"
    aws_profile = "default"
    ecr_repo_name = "ghost"
    ecr_repo_tag = "latest"
  }
}