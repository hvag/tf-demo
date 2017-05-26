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


data "terraform_remote_state" "east-state" {
    backend = "s3"
    config {
        bucket  = "hvag-tfdemo-state"
        key     = "east/terraform.tfstate"
        region  = "us-east-1"
    }
}


provider "aws" {
    region = "${data.terraform_remote_state.vpc-state.east-region}"
}
