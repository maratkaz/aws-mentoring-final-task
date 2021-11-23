resource "aws_iam_instance_profile" "ghost_app_profile" {
  name = "ghost_app_profile"
  role = aws_iam_role.ghost_app.name
}

resource "aws_iam_role" "ghost_app" {
  name = "ghost_app"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "ec2:Describe*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ssm:GetParameter*",
                "secretsmanager:GetSecretValue",
                "kms:Decrypt",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

}