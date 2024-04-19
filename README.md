# Configure the Project
* In Cloud Formation upload the yaml template from project root to create the ec2, cloud9 instances and role.
* Modify the ec2 security to use the Instance Profile you created in Cloud Formation (TerraformC9InstanceProfile)
* In Cloud 9 run `chmod +x resize.sh` then `./resize.sh` 60
* In Cloud 9 run `chmod +x setup.sh` then `./setup.sh` to install homebrew, tfenv, terraform, checkov
* In Cloud 9 configure homebrew by running `(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/ec2-user/.bashrc`
* In Cloud 9 finish configuring tools by running `eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"`
* Now tell tfenv to use latest wtih `tfenv use latest`

* Next clone the repo from <URL>
* Inside the folder module-aws-tf-cicd run `terraform init` and then `terraform test` and you should see 2 passed and 0 failed tests







