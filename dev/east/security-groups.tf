/**
 * Terraform Demo
 * By: Mark
 */

 # VPC Default Security Group - Priv2
resource "aws_security_group" "Priv2-ALL" {
    vpc_id = "${data.terraform_remote_state.vpc-state.vpc-east-vpc-id}"
    name = "Priv2-ALL"
    description = "Allow all traffic amongst instances on Priv2 subnet"

    # Review the CIDR blocks below to see if they can be made to work with COUNT

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["${element(data.terraform_remote_state.vpc-state.priv2_subnet_addresses, 0)}",
                       "${element(data.terraform_remote_state.vpc-state.priv2_subnet_addresses, 1)}",
                       "${element(data.terraform_remote_state.vpc-state.priv2_subnet_addresses, 2)}"]
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${element(data.terraform_remote_state.vpc-state.priv2_subnet_addresses, 0)}",
                       "${element(data.terraform_remote_state.vpc-state.priv2_subnet_addresses, 1)}",
                       "${element(data.terraform_remote_state.vpc-state.priv2_subnet_addresses, 2)}"]
    }

    tags {
        Name = "Priv2-ALL"
        Project   = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform = "true"
    }
}


# Security Group - Bastion -> Private
resource "aws_security_group" "SG-BastionToPrivate" {
    vpc_id = "${data.terraform_remote_state.vpc-state.vpc-east-vpc-id}"
    name = "SG-BastionToPrivate"
    description = "Security Group - Bastion to Private"

    ingress {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_blocks = ["${aws_instance.East-Bastion1.private_ip}/32"]
    }

    ingress {
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        cidr_blocks = ["${aws_instance.East-Bastion-L1.private_ip}/32"]
    }

    tags {
        Name      = "SG-BastionToPrivate"
        Project   = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform = "true"
    }
}
