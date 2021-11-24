resource "aws_ecs_cluster" "ghost" {
  name = "ghost"
  depends_on = [ module.ecr_mirror ]
}