/**
 * Terraform Demo
 * By: Mark
 */

provider "aws" {
      region = "${var.region}"
}


# VPC Default Security Group - Public - Windows
resource "aws_security_group" "SG-Public-Default-Win" {
    vpc_id = "${var.vpc-id}"
    name = "SG-Public-Default-Win"
    description = "Default Public Security Group (Windows) - Ingress RDP - Egress ALL traffic"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["${var.vpc-ingressIP}"]
    }

    tags {
        Name = "SG-Public-Default-Win"
        Project   = "${var.project-name}"
        Terraform = "true"
    }
}


# VPC Default Security Group - Public - Linux
resource "aws_security_group" "SG-Public-Default-Linux" {
    vpc_id = "${var.vpc-id}"
    name = "SG-Public-Default-Linux"
    description = "Default Public Security Group (Linux) - Ingress SSH - Egress ALL traffic"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc-ingressIP}"]
    }

    tags {
        Name = "SG-Public-Default-Linux"
        Project   = "${var.project-name}"
        Terraform = "true"
    }
}
