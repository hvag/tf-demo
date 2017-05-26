/**
 * Terraform Demo
 * By: Mark
 */

module "vpc-east" {
    source = "../../modules/vpc"

    name            = "VPC-EAST"
    project-name    = "${var.project-name}"
    region          = "${var.east-region}"
    network-address = "${var.vpc-east-network-address}"
}


module "vpc-west" {
    source = "../../modules/vpc"

    name            = "VPC-WEST"
    project-name    = "${var.project-name}"
    region          = "${var.west-region}"
    network-address = "${var.vpc-west-network-address}"
}


module "vpc-east-subnets" {
    source = "../../modules/vpc-subnets"

    vpc-id = "${module.vpc-east.vpc-id}"

    project-name           = "${var.project-name}"
    region                 = "${var.east-region}"
    priv1_subnet_addresses = [ "${var.vpc-east-network-subnet}.0.0/19",   "${var.vpc-east-network-subnet}.32.0/19",  "${var.vpc-east-network-subnet}.64.0/19"  ]
    priv2_subnet_addresses = [ "${var.vpc-east-network-subnet}.192.0/21", "${var.vpc-east-network-subnet}.200.0/21", "${var.vpc-east-network-subnet}.208.0/21" ]
    pub_subnet_addresses   = [ "${var.vpc-east-network-subnet}.128.0/20", "${var.vpc-east-network-subnet}.144.0/20", "${var.vpc-east-network-subnet}.160.0/20" ]
}


module "vpc-west-subnets" {
    source = "../../modules/vpc-subnets"

    vpc-id = "${module.vpc-west.vpc-id}"

    project-name           = "${var.project-name}"
    region                 = "${var.west-region}"
    priv1_subnet_addresses = [ "${var.vpc-west-network-subnet}.0.0/19",   "${var.vpc-west-network-subnet}.32.0/19",  "${var.vpc-west-network-subnet}.64.0/19"  ]
    priv2_subnet_addresses = [ "${var.vpc-west-network-subnet}.192.0/21", "${var.vpc-west-network-subnet}.200.0/21", "${var.vpc-west-network-subnet}.208.0/21" ]
    pub_subnet_addresses   = [ "${var.vpc-west-network-subnet}.128.0/20", "${var.vpc-west-network-subnet}.144.0/20", "${var.vpc-west-network-subnet}.160.0/20" ]
}


module "vpc-east-IG" {
    source = "../../modules/vpc-IG"

    name = "VPC-EAST-IG"

    vpc-id         = "${module.vpc-east.vpc-id}"
    pub-subnet-ids = "${module.vpc-east-subnets.pub-subnet-ids}"
    
    project-name = "${var.project-name}"
    region       = "${var.east-region}"    
}


module "vpc-west-IG" {
    source = "../../modules/vpc-IG"

    name = "VPC-WEST-IG"

    vpc-id         = "${module.vpc-west.vpc-id}"
    pub-subnet-ids = "${module.vpc-west-subnets.pub-subnet-ids}"
    
    project-name = "${var.project-name}"
    region       = "${var.west-region}"    
}


module "vpc-east-SG" {
    source = "../../modules/security-groups"

    region = "${var.east-region}"
    vpc-id = "${module.vpc-east.vpc-id}"

    project-name = "${var.project-name}"

    vpc-ingressIP        = "${var.vpc-ingressIP}"
    pub_subnet_addresses = [ "${var.vpc-east-network-subnet}.128.0/20", "${var.vpc-east-network-subnet}.144.0/20", "${var.vpc-east-network-subnet}.160.0/20" ]
}


module "vpc-west-SG" {
    source = "../../modules/security-groups"

    region = "${var.west-region}"
    vpc-id = "${module.vpc-west.vpc-id}"

    project-name = "${var.project-name}"
    
    vpc-ingressIP = "${var.vpc-ingressIP}"
    pub_subnet_addresses   = [ "${var.vpc-west-network-subnet}.128.0/20", "${var.vpc-west-network-subnet}.144.0/20", "${var.vpc-west-network-subnet}.160.0/20" ]
}
