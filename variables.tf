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