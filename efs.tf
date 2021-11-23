resource "aws_efs_file_system" "ghost_content" {
  creation_token = "ghost_content"

  tags = {
    Name = "ghost_content"
  }
}

resource "aws_efs_mount_target" "efs_mnt_a" {
  file_system_id  = aws_efs_file_system.ghost_content.id
  subnet_id       = aws_subnet.public_a.id
  security_groups = [ aws_security_group.efs.id ]
}

resource "aws_efs_mount_target" "efs_mnt_b" {
  file_system_id  = aws_efs_file_system.ghost_content.id
  subnet_id       = aws_subnet.public_b.id
  security_groups = [ aws_security_group.efs.id ]
}

resource "aws_efs_mount_target" "efs_mnt_c" {
  file_system_id  = aws_efs_file_system.ghost_content.id
  subnet_id       = aws_subnet.public_c.id
  security_groups = [ aws_security_group.efs.id ]
}