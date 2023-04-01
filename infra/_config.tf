terraform {
   backend "s3" {
     bucket = "ec2-key-home-task"
     key    = "terraform/terraform.tfstate"
     region = "${var.aws_region}"
   }
 }

 provider "aws" {
   region = "${var.aws_region}"

   default_tags {
     tags = local.tags
   }
 }