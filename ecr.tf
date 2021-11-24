resource "aws_ecr_repository" "ghost" {
  name = "ghost"

  image_scanning_configuration {
    scan_on_push = true
  }
}

module "ecr_mirror" {
  source         = "TechToSpeech/ecr-mirror/aws"
  aws_account_id = local.ecr.aws_account_id
  aws_region     = local.ecr.aws_region
  docker_source  = local.ecr.docker_source
  aws_profile    = local.ecr.aws_profile
  ecr_repo_name  = local.ecr.ecr_repo_name
  ecr_repo_tag   = local.ecr.ecr_repo_tag
  depends_on     = [ aws_ecr_repository.ghost ]
}