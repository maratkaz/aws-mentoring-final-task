resource "aws_ecs_cluster" "ghost" {
  name = "ghost"
  depends_on = [ module.ecr_mirror ]
}

resource "aws_ecs_task_definition" "ghost_task_definition" {
  depends_on = [aws_db_instance.ghost, aws_ecr_repository.ghost]
  family = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  task_role_arn            = aws_iam_role.ghost_app.arn
  execution_role_arn       = aws_iam_role.ghost_app.arn
  container_definitions    = data.template_file.task_definition_template.rendered
#   container_definitions = jsonencode([
#     {
#       name      = "first"
#       image     = "service-first"
#       cpu       = 256
#       memory    = 1024
#       essential = true
#       environment = [
#         {
#           database__client = "mysql"
#           database__connection__host = "db"
#           database__connection__user = "admin"
#           database__connection__password = "foobarbaz"
#           database__connection__database = "mydb"
#         }
#       ]
#       portMappings = [
#         {
#           containerPort = 2368
#           hostPort      = 2368
#         }
#       ]
#       mountPoints = [
#         {
#             containerPath = "/var/lib/ghost/content"
#             sourceVolume = "efs-storage"
#         }
#       ]
#     }
#   ])

  volume {
    name      = "efs-storage"
    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.ghost_content.id
      root_directory          = "/"
    }
  }

}

data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL = replace(aws_ecr_repository.ghost.repository_url, "https://", "")
    DB_URL = aws_db_instance.ghost.address
  }
}

resource "aws_ecs_service" "ghost_service" {
  name            = "ghost_service"
  cluster         = aws_ecs_cluster.ghost.id
  task_definition = aws_ecs_task_definition.ghost_task_definition.arn
  desired_count   = 1

  network_configuration {
    security_groups = [aws_security_group.fargate_pool.id]
    subnets         = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fargate.arn
    container_name   = "ghost"
    container_port   = 2368
  }

}

