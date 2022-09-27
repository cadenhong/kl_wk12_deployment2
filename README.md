# Deployment 2: Launching a Flask Application via EB CLI

#### Assignment instructions can be found here: [Deployment2_Instructions.pdf](https://github.com/cadenhong/kl_wk12_deployment2/blob/main/Deployment-2_Assignment.pdf)

## Tasks
- Complete the deployment based on provided instructions
- Document steps taken and any observations made (see [Deployment2_Documentation.pdf](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/Deployment2_Documentation.pdf))
- Diagram the deployment pipeline (see [Deployment2_Diagram.png](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/Deployment2_Diagram.png))
- Modify/add to the pipeline

## Deployment Steps
1. Spin up an EC2 instance with Ubuntu AMI and ports 22, 80, and 8080
2. SSH into the EC2 and run [setup_jenkins.sh](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/setup_jenkins.sh) to install Jenkins and setup jenkins user
3. On AWS, create a new IAM user with programmatic access (policy: AdministratorAccess)
4. Back on the EC2, run [setup_awscli.sh](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/setup_awscli.sh) using credentials generated from Step 3
5. `sudo su - jenkins -s /bin/bash` to activate jenkins user and run [setup_ebcli.sh](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/setup_ebcli.sh) to install and setup EB CLI
6. Connect [this GitHub repository](https://github.com/cadenhong/kl_wk12_deployment2) to Jenkins via Multibranch build
7. Deploy the Flask application via EB CLI
```
sudo su - jenkins -s /bin/bash
cd workspace/<project-name>
eb init
eb create
```
8. Edit the Jenkinsfile to add a "Deploy" stage with
`sh '/var/lib/jenkins/.local/bin/eb deploy <environment-name>'` - see the difference between the [original file](https://github.com/kura-labs-org/kuralabs_deployment_2/blob/main/Jenkinsfile) vs. [edited file](https://github.com/cadenhong/kl_wk12_deployment2/blob/main/Jenkinsfile)

![Screen Shot 2022-09-27 at 3 09 23 PM](https://user-images.githubusercontent.com/83370640/192614685-25143447-21f5-4b71-8903-b65e5575e263.png)

## Modifications Made
#### - Webhook to automate the deployment - changes pushed to the code are picked up by Jenkins via the webhook and redeployed in Jenkins pipeline's Build stage:

![Screen Shot 2022-09-27 at 2 57 10 PM](https://user-images.githubusercontent.com/83370640/192612429-bde1d59e-38dc-46b4-9f27-f321a140bca5.png)

![Screen Shot 2022-09-27 at 3 10 12 PM](https://user-images.githubusercontent.com/83370640/192614842-0e4b111e-68e5-49a6-8259-8bf8b72b933d.png)

#### - Installed Slack plugin on Jenkins to set up notifications based on status of build for each stage in the pipeline:

![Screen Shot 2022-09-27 at 3 02 48 PM](https://user-images.githubusercontent.com/83370640/192613458-76b0df6e-6be2-4732-b4d2-17bbe7eb37f7.png)

Code added inside Jenkinsfile:
```
  post {
    success {
      slackSend (message: "INFO: Build Number ${env.BUILD_NUMBER} - ${STAGE_NAME} Stage completed successfully!")
    }
    failure {
      slackSend (message: "WARNING: Build Number ${env.BUILD_NUMBER} - ${STAGE_NAME} Stage has failed!")
    }
  }
```

## Files and Folders
- [.gitignore](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/.gitignore): Contains files to ignore when pushing to GitHub repository
- [Deployment2_Diagram.png](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/Deployment2_Diagram.png): Diagram of the pipeline
- [Deployment2_Documentation.docx](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/Deployment2_Documentation.docx): Word file of notes and observations made during deployment
- [Deployment2_Documentation.pdf](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/Deployment2_Documentation.pdf): PDF of notes and observations made during deployment
- [kuralabs_deployment_2-main.zip](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/kuralabs_deployment_2-main.zip): Main project code, includes application code and dependencies
- [setup_awscli.sh](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/setup_awscli.sh): Bash script to setup and install AWS CLI
- [setup_ebcli.sh](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/setup_ebcli.sh): Bash script to setup and install EB CLI
- [setup_jenkins.sh](https://github.com/cadenhong/kl_wk12_deployment2_organized/blob/main/setup_jenkins.sh): Bash script to setup and install Jenkins

## Tools
- Jenkins
- GitHub
- Python
- Flask
- AWS CLI
- EB CLI
- AWS IAM
- AWS EC2
- AWS Elastic Beanstalk
- Diagrams.net
