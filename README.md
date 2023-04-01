# terraform-ansible-homeTask

## Instructions

__Terraform__
1. Open your AWS console

2. Change your region to `us-east-2`. From the AWS console create an S3 bucket in `us-east-2` to store backend terraform state e.g `infra-tf-cloud-home-task`

3. Create a private key pair for your EC2 instance called e.g `ec2-key-home-task`

3. Setup your CloudShell. Open CloudShell in the `us-east-2` region. Install the following:

- Install Terraform
    - `wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip`
    - `unzip terraform_1.0.7_linux_amd64.zip`
    - `mkdir ~/bin`
    - `mv terraform ~/bin`

4. Deploy Terraform infrastructure
    - Clone Github code  `git clone https://github.com/crisroddev/terraform-ansible-homeTask.git`
    - Change in _`config.tf` the bucket name with the one you created
    - Change in `ec2.tf` the `ami-id` you will want to work
    - `cd` into the `infra` folder
    - `terraform init`
    - `terraform apply`

5. Once the script is complete, you can go to the AWS account and look for the the newly created resources. 

6. SSH into the EC2 instance with username `ubuntu` and the key created top check access.

__Terraform With Pipeline__

__Infrastructure Diagram__