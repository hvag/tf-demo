/**
 * Terraform Demo
 * By: Mark
 */


# Create Windows 2016 Server Instance
resource "aws_instance" "East-DC1" {
    ami = "${data.terraform_remote_state.east-state.windows2016-Image}"
    instance_type = "t2.small"

    # VPC subnet
    subnet_id = "${element(split(":", data.terraform_remote_state.vpc-state.vpc-east-priv2-subnet-ids), 0)}"

    # Security Group
    vpc_security_group_ids = ["${data.terraform_remote_state.east-state.east-SG-BastionToPrivate-id}",
                              "${data.terraform_remote_state.east-state.Priv2-ALL-id}"]

    # Public SSH key
    key_name = "${data.terraform_remote_state.east-state.east-key-pair-id}"

    # Private IP - static
    private_ip = "10.100.192.10"

    root_block_device {
        volume_size = "40"
        volume_type = "gp2"
    }

    tags {
        Name      = "East-DC1"
        Project   = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform = "true"
        Description = "Domain Controller - DC1"
    }
}


# Create Windows 2016 Server Instance
resource "aws_instance" "East-DC2" {
    ami = "${data.terraform_remote_state.east-state.windows2016-Image}"
    instance_type = "t2.small"

    # VPC subnet
    subnet_id = "${element(split(":", data.terraform_remote_state.vpc-state.vpc-east-priv2-subnet-ids), 1)}"

    # Security Group
    vpc_security_group_ids = ["${data.terraform_remote_state.east-state.east-SG-BastionToPrivate-id}",
                              "${data.terraform_remote_state.east-state.Priv2-ALL-id}"]

    # Public SSH key
    key_name = "${data.terraform_remote_state.east-state.east-key-pair-id}"

    # Private IP - static
    private_ip = "10.100.200.10"

    root_block_device {
        volume_size = "40"
        volume_type = "gp2"
    }

    tags {
        Name      = "East-DC2"
        Project   = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform = "true"
        Description = "Domain Controller - DC2"
    }
}
