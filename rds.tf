resource "aws_db_subnet_group" "ghost" {
  name       = "ghost"
  subnet_ids = [aws_subnet.private_db_a.id, aws_subnet.private_db_b.id, aws_subnet.private_db_c.id]
}

resource "aws_db_instance" "ghost" {
  allocated_storage    = 20
  engine               = "mysql"
  storage_type         = "gp2"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = var.db_pass
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  security_group_names = [aws_security_group.mysql]
  db_subnet_group_name = [aws_db_subnet_group.ghost]
}

resource "aws_ssm_parameter" "secret" {
  name        = "/ghost/dbpassw"
  description = "db password"
  type        = "SecureString"
  value       = var.db_pass
}