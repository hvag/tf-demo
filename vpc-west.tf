/**
 * Terraform Demo
 * By: Mark
 */

module "vpc-west" {
    source = "modules/vpc"

    region     = "us-west-1"
    name       = "VPC-WEST"
    cidr_block = "10.200.0.0/16"
}
