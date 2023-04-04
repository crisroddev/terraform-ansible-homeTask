# terraform-ansible-homeTask
[![Terraform](https://github.com/crisroddev/terraform-ansible-homeTask/actions/workflows/terraform.yml/badge.svg)](https://github.com/crisroddev/terraform-ansible-homeTask/actions/workflows/terraform.yml)
## Instructions

__Terraform__
1. Open your AWS console

2. Change your region to `us-east-2`. From the AWS console create an S3 bucket in `us-east-2` to store backend terraform state e.g `infra-tf-cloud`

3. Create a Bucket to upload `security_agent_config` and `security_agent_installer` 

4. Create a private key pair for your EC2 instance called e.g `ec2-key-home-task`
    - Update `modules/ec2/ec2.tf` with the key pem created

5. In `modules/ec2/ec2.tf` update ingress rules for port 22 ssh with your IP to keep security

6. Update `config.tf` the bucket name with the one you created to store terraform backend state

7. Setup your CloudShell. Open CloudShell in the `us-east-2` region. Install the following:

8. Deploy Terraform infrastructure
    - Clone Github code  `git clone https://github.com/crisroddev/terraform-ansible-homeTask.git`
    - Change in `ec2.tf` the `ami-id` if you work in other region than `us-east-2` every region has different ami ids.
    - As you make a push into the repo github actions will deploy infrastructure, make sure in github settings you provide your AWS keys:
        -  AWS_ACCESS_KEY_ID
        - AWS_SECRET_ACCESS_KEY

9. As github actions deploy infrastructure in the github actions output you will have the ec2 dns
    - Add ec2 dns to inventory file
    - Create secret for the sceurity agent installer with `ansible-vault create secret.yaml`:
        `my_secret: secret`

10. SSH to EC2 and run command to download files from bucket to EC2
    ```aws configure set aws_access_key_id "{ACCESS_KEY}" && aws configure set aws_secret_access_key "{SECRET_KEY}" && aws configure set region "{REGION}" && aws configure set   output "json"
    echo "Downlading files"
    aws s3 sync s3://bucket-name .
    chmod +x security_agent_installer.sh```

11. Finally run ansible
    - `ansible-playbook playbook.yaml --vault-password-file=secret.yaml   -i inventory --user ubuntu  --key-file=ec2-key-home-task.pem`
    - Check process: 
        - ssh into EC2
        - `vim test.txt` --> If `test.txt` has `Agent Installation Succeeded`, it means the playbook succesfully installed the security installer.

12. Destroy Infrastructure:
    - `cd ./infra && terraform destroy`

## Decisions
For this project I needed to deploy infrastructure with IaC:
1. Infrastructure Deployed:
    - VPC
        - Private Subnet
        - Public Subnet
        - Internet Gateway
        - Public Routes
        - Private Routes
        -  Nat Gateway
        - Route Table Association
    - EC2
        - Ubuntu EC2: Installing ansible from startup
        - Execution to get EC2 DNS
        - Execution to get ip address to add it to security group ssh ingress
        - Security Group
            Ingress: 80, 443, 22
            Egress: 443, 80

2. Ansible:
    - Playbook to deploy security installer with security config file giving the token with ansible security levels using ansible-vault
    - Inventory to have mapped the host --> EC2 host or Ec2 dns
    - This playbook installs security agent, to check if it gets installed its creates a test.txt with the result.

## File Structure
######################################################################################
.  # Root
├── .github                   
│   └── workflows
|       └── terraform.yaml       # Terraform automation pipeline
│── Infra
|    └── Modules
|    |    └── Ec2                # EC2 configuration deployment and ansible files
|    |    └── VPC                # VPC configuration deployment
|     └── _config.tf
|     └── _data.tf
|     └── output.tf
|     └──ec2.tf
|     └── main.tf
|     └── variables.tf
######################################################################################