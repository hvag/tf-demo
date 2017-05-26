/**
 * Terraform Demo
 * By: Mark
 */

output "project-name" {
    value = "${var.project-name}"
}

output "east-region" {
    value = "${var.east-region}"
}

output "vpc-east-pub-subnet-ids" {
    value = "${module.vpc-east-subnets.pub-subnet-ids}"
}

output "vpc-east-priv1-subnet-ids" {
    value = "${module.vpc-east-subnets.priv1-subnet-ids}"
}

output "vpc-east-priv2-subnet-ids" {
    value = "${module.vpc-east-subnets.priv2-subnet-ids}"
}

output "vpc-east-SG-Public-Default-Win-id" {
    value = "${module.vpc-east-SG.SG-Public-Default-Win-id}"
}

output "vpc-east-SG-PublicToPrivate-id" {
    value = "${module.vpc-east-SG.SG-PublicToPrivate-id}"
}

output "vpc-east-vpc-id" {
    value = "${module.vpc-east.vpc-id}"
}
