locals {
  # -- CodeCommit --
  # CodeCommit Repository Names
  module_aws_tf_cicd_repository_name          = "module-aws-tf-cicd"
  aws_devops_core_repository_name             = "aws-devops-core"
  production_workload_repository_name = "prod-workload"


  # -- CodeBuild --
  # - CodeBuild Project Names -
  # 'module-aws-tf-cicd' Build Projects
  tf_test_module_aws_tf_cicd_codebuild_project_name = "TerraformTest-module-aws-tf-cicd"
  chevkov_module_aws_tf_cicd_codebuild_project_name = "Checkov-module-aws-tf-cicd"
  # 'aws-devops-core' Build Projects
  tf_test_aws_devops_core_codebuild_project_name = "TerraformTest-aws-devops-core"
  chevkov_aws_devops_core_codebuild_project_name = "Checkov-aws-devops-core"
  # 'production-workload' Build Projects
  tf_test_production_workload_codebuild_project_name  = "TerraformTest-prod-workload"
  chevkov_production_workload_codebuild_project_name  = "Checkov-prod-workload"
  tf_apply_production_workload_codebuild_project_name = "TFApply-prod-workload"


  # - CodeBuild buildspec paths -
  tf_test_path_to_buildspec  = "./buildspec/tf-test-buildspec.yml"  # Terraform Test Framework (Test Functionality)
  checkov_path_to_buildspec  = "./buildspec/checkov-buildspec.yml"  # Checkov (Test Security)
  tf_apply_path_to_buildspec = "./buildspec/tf-apply-buildspec.yml" # TF Apply (Provision Resources)


  # -- CodePipeline --
  # - CodePipeline Pipeline Names -
  tf_module_validation_module_aws_tf_cicd_codepipeline_pipeline_name   = "tf-module-validation-module-aws-tf-cicd"
  tf_deployment_production_workload_codepipeline_pipeline_name = "tf-deploy-prod-workload"

  # - CloudWatch Triggers for CodePipeline
  tf_module_validation_module_aws_tf_cicd_cloudwatch_event_pattern = <<-EOF
        {
          "source": [ "aws.codecommit" ],
          "detail-type": [ "CodeCommit Repository State Change" ],
          "resources": [ "${local.module_aws_tf_cicd_repository_name}" ],
          "detail": {
            "event": [
              "referenceCreated",
              "referenceUpdated"
              ],
            "referenceType":["branch"],
            "referenceName": ["${local.cloudwatch_branch_to_monitor}"]
          }
        }
      EOF

  cloudwatch_branch_to_monitor                                       = "main"
  tf_deployment_production_workload_cloudwatch_event_pattern = <<-EOF
        {
          "source": [ "aws.codecommit" ],
          "detail-type": [ "CodeCommit Repository State Change" ],
          "resources": [ "${local.production_workload_repository_name}" ],
          "detail": {
            "event": [
              "referenceCreated",
              "referenceUpdated"
              ],
            "referenceType":["branch"],
            "referenceName": ["${local.cloudwatch_branch_to_monitor}"]
          }
        }
      EOF


  # Images
  checkov_image = "bridgecrew/checkov"
}


