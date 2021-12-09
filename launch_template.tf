data "aws_ami" "latest_amazon_linux" {
  owners = ["amazon"]
  most_recent = true
  filter {
      name = "name"
      values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "ghost" {
  name          = "ghost"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  key_name      = var.key_pair
  vpc_security_group_ids = [aws_security_group.ec2_pool.id]
  user_data     = filebase64("user_data.sh")
  depends_on    = [ aws_db_instance.ghost ]

  iam_instance_profile {
    name = "ghost_app_profile"
  }

  # block_device_mappings {
  #   device_name = "/dev/sda1"

  #   ebs {
  #     volume_size           = 8
  #     volume_type           = "gp2"
  #     delete_on_termination = true
  #   }
  # }

#   network_interfaces {
#     associate_public_ip_address = false
#     security_groups             = [aws_security_group.ec2_pool.id]
#   }

}