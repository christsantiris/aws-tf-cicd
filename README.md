# Configure the Project
* In Cloud Formation upload the yaml template from project root to create the ec2, cloud9 instances and role.
* Modify the ec2 security to use the Instance Profile you created in Cloud Formation (TerraformC9InstanceProfile)
* In Cloud 9 run `chmod +x resize.sh` then `./resize.sh` 60
* In Cloud 9 run `chmod +x setup.sh` then `./setup.sh` to install homebrew, tfenv, terraform, checkov
* In Cloud 9 configure homebrew by running `(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/ec2-user/.bashrc`
* In Cloud 9 finish configuring tools by running `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"`
* Now tell tfenv to use latest wtih `tfenv use latest`

* Next clone the repo from https://github.com/christsantiris/aws-tf-cicd
* Inside the folder module-aws-tf-cicd run `terraform init` and then `terraform test` and you should see 2 passed and 0 failed tests
* run `pwd` to get the absolute path of the directory and use it to run checkov `checkov --directory /home/ec2-user/environment/aws-tf-cicd/modules/module-aws-tf-cicd`

* Afer checkov runs cd into the aws-devops-core directory and run `terraform init` then `terraform plan` which should show 41 resources about to be created then `terraform apply -auto-approve`
* Head to AWS CodePipeline and observe that the "pull code from commit" action failed because branch main does not exist because the code isn't pushed.
* Uncomment the backend section in aws-devops-core/provider.tf and use the values from the tf output to add bucket and dynamo table values
* Run `terraform init` and hookup the backend. Check out the s3 to see the tfstate file pushed there
* cd back into modules/module-aws-tf-cicd and initialize git, create the main branch and connect code commit by running `git remote add origin codecommit::us-east-1://module-aws-tf-cicd` then push the code. The module validation pipeline should now run

* Next trigger the pipeline for the production workload
* cd into the production workload directory
* update the provider.tf file backend with the production workload bucket and db from the apply output from before. Re run apply if needed
* push the code. The pipeline should succeed

* Now cd back into aws-devops-core
* uncomment the section that says "Add Manual Approval" in the main.tf file leaving the line for NotificationArn commented out
* run `terraform plan then` `terraform apply -auto-approve` and confirm the prod workload pipeline now has a manual approval step before apply
* uncomment the sns resources in main.tf
* run `terraform apply` again and confirm the subscription via email

* Test the manual approval by navigating to the production-workload directory
* in main.tf change the s3 bucket prefix to something like prod-resource-new or prod-resource-2
* commit and push the change. the manual approval email should arrive if everything was done correctly

* Destroying the project
* comment out main.tf and main.tftest.hcl in the production workload directory
* push the changes
* in aws-devops-core directory comment out the backend block in the provider.tf file
* run `terraform init -migrate-state` to migrate the state from s3 to local server
* run `terraform destroy -auto-approve`
* remove this stack from cloud formation







