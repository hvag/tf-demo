/**
 * Terraform Demo
 * By: Mark
 */

module "vpc-east" {
    source = "../../modules/vpc"

    project-name    = "TF-DEMO"
    name            = "VPC-EAST"
    region          = "${var.east-region}"
    network-address = "${var.vpc-east-network-address}"
}


module "vpc-west" {
    source = "../../modules/vpc"

    project-name    = "TF-DEMO"
    name            = "VPC-WEST"
    region          = "${var.west-region}"
    network-address = "${var.vpc-west-network-address}"
}


module "vpc-east-subnets" {
    source = "../../modules/vpc-subnets"

    vpc-id                 = "${module.vpc-east.vpc-id}"

    project-name           = "TF-DEMO"
    region                 = "${var.east-region}"
    priv1_subnet_addresses = [ "${var.vpc-east-network-subnet}.0.0/19",   "${var.vpc-east-network-subnet}.32.0/19",  "${var.vpc-east-network-subnet}.64.0/19"  ]
    priv2_subnet_addresses = [ "${var.vpc-east-network-subnet}.192.0/21", "${var.vpc-east-network-subnet}.200.0/21", "${var.vpc-east-network-subnet}.208.0/21" ]
    pub_subnet_addresses   = [ "${var.vpc-east-network-subnet}.128.0/20", "${var.vpc-east-network-subnet}.144.0/20", "${var.vpc-east-network-subnet}.160.0/20" ]
}


module "vpc-west-subnets" {
    source = "../../modules/vpc-subnets"

    vpc-id                 = "${module.vpc-west.vpc-id}"

    project-name           = "TF-DEMO"
    region                 = "${var.west-region}"
    priv1_subnet_addresses = ["${var.vpc-west-network-subnet}.0.0/19",   "${var.vpc-west-network-subnet}.32.0/19",  "${var.vpc-west-network-subnet}.64.0/19"  ]
    priv2_subnet_addresses = ["${var.vpc-west-network-subnet}.192.0/21", "${var.vpc-west-network-subnet}.200.0/21", "${var.vpc-west-network-subnet}.208.0/21" ]
    pub_subnet_addresses   = ["${var.vpc-west-network-subnet}.128.0/20", "${var.vpc-west-network-subnet}.144.0/20", "${var.vpc-west-network-subnet}.160.0/20" ]
}
