resource "aws_codecommit_repository" "codecommit" {
  for_each        = var.codecommit_repos == null ? {} : var.codecommit_repos
  repository_name = each.value.repository_name
  description     = each.value.description
  default_branch  = each.value.default_branch
  tags            = each.value.tags

  #suppress check in checkov
  #checkov:skip=CKV2_AWS_37: "Ensure CodeCommit associates an approval rule"
}

