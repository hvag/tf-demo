/**
 * Terraform Demo
 * By: Mark
 */

# Create Windows 2016 Server Instance
resource "aws_instance" "windows2016-Image" {
    ami = "ami-f1b5cfe7"
    instance_type = "t2.micro"

    # VPC subnet
    subnet_id = "${element(split(":", data.terraform_remote_state.vpc-state.vpc-east-pub-subnet-ids), 0)}"

    # Security Group
    vpc_security_group_ids = ["${data.terraform_remote_state.vpc-state.vpc-east-SG-Public-Default-Win-id}"]

    # Public SSH key
    key_name = "${aws_key_pair.TF-Demo-Dev-Key.key_name}"

    tags {
        Name      = "windows2016-Image"
        Project   = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform = "true"
        Description = "Windows 2016 Golden Image - Source"
    }
}


resource "aws_ami_from_instance" "windows2016-Image" {
    name               = "windows2016-Image"
    source_instance_id = "${aws_instance.windows2016-Image.id}"

    tags {
        Name        = "windows2016-Image"
        Project     = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform   = "true"
        Description = "Windows 2016 Golden Image - AMI"
    }
}


resource "aws_ami_copy" "windows2016-Image" {
    name              = "windows2016-Image-Encrypted"
    description       = "Windows 2016 Golden Image - AMI - Encrypted"
    source_ami_id     = "${aws_ami_from_instance.windows2016-Image.id}"
    source_ami_region = "${data.terraform_remote_state.vpc-state.east-region}"
    encrypted         = "true"

    tags {
        Name        = "windows2016-Image"
        Project     = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform   = "true"
        Description = "Windows 2016 Golden Image - AMI - Encrypted"
    }
}
