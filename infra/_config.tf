terraform {
   backend "s3" {
     bucket = "infra-tf-cloud"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }
 }

 provider "aws" {
   region = var.aws_region

   default_tags {
     tags = local.tags
   }
 }