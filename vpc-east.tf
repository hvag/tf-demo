/**
 * Terraform Demo
 * By: Mark
 */

module "vpc-east" {
    source = "modules/vpc"

    region     = "us-east-1"
    name       = "VPC-EAST"
    cidr_block = "10.100.0.0/16"
}
