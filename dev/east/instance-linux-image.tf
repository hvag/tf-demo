/**
 * Terraform Demo
 * By: Mark
 */

# Create Ubuntu Server 16.04 Instance
resource "aws_instance" "UbuntuServer1604-Image" {
    ami = "ami-80861296"
    instance_type = "t2.micro"

    # VPC subnet
    subnet_id = "${element(split(":", data.terraform_remote_state.vpc-state.vpc-east-pub-subnet-ids), 0)}"

    # Security Group
    vpc_security_group_ids = ["${data.terraform_remote_state.vpc-state.vpc-east-SG-Public-Default-Linux-id}"]

    # Public SSH key
    key_name = "${aws_key_pair.TF-Demo-Dev-Key.key_name}"

    tags {
        Name        = "UbuntuServer1604-Image"
        Project     = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform   = "true"
        Description = "Ubuntu Server 16.04 Golden Image - Source"
    }
}


resource "aws_ami_from_instance" "UbuntuServer1604-Image" {
    name               = "UbuntuServer1604-Image"
    source_instance_id = "${aws_instance.UbuntuServer1604-Image.id}"

    tags {
        Name        = "UbuntuServer1604-Image"
        Project     = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform   = "true"
        Description = "Ubuntu Server 16.04 Golden Image - AMI"
    }
}


resource "aws_ami_copy" "UbuntuServer1604-Image" {
    name              = "UbuntuServer1604-Image-Encrypted"
    description       = "Ubuntu Server 16.04 Golden Image - AMI - Encrypted"
    source_ami_id     = "${aws_ami_from_instance.UbuntuServer1604-Image.id}"
    source_ami_region = "${data.terraform_remote_state.vpc-state.east-region}"
    encrypted         = "true"

    tags {
        Name        = "UbuntuServer1604-Image"
        Project     = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform   = "true"
        Description = "Ubuntu Server 16.04 Golden Image - AMI - Encrypted"
    }
}
