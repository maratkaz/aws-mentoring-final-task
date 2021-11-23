resource "aws_iam_instance_profile" "ghost_app_profile" {
  name = "ghost_app_profile"
  role = aws_iam_role.ghost_app.name
}

resource "aws_iam_role" "ghost_app" {
  name = "ghost_app"
  path = "/"

  assume_role_policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
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
            ],
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
})
}