/**
 * Terraform Demo
 * By: Mark
 */

# During build, the VPC outputs the region that it is constructed in.
# Get that for provider region below.

data "terraform_remote_state" "vpc-state" {
    backend = "s3"
    config {
        bucket  = "hvag-tfdemo-state"
        key     = "vpc/terraform.tfstate"
        region  = "us-east-1"
    }
}


provider "aws" {
    region = "${data.terraform_remote_state.vpc-state.east-region}"
}


# Query AWS for the latest Windows 2016 Base AMI
# We don't yet want the image to be rebuilt whenever there's a new AMI
# We will use the current latest: ami-f1b5cfe7
data "aws_ami" "windows2016-image" {
    most_recent = "true"

    filter {
        name   = "name"
        values = ["Windows_Server-2016-English-Full-Base*"]
    }
}


# Query AWS for the latest Ubuntu Base AMI
# We will use the current latest: ami-80861296
data "aws_ami" "ubuntu1604-image" {
    most_recent = "true"

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server*"]
    }
}
