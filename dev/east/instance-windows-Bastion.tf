/**
 * Terraform Demo
 * By: Mark
 */

# Create Windows 2016 Server Instance
resource "aws_instance" "East-Bastion1" {
    ami = "${aws_ami_copy.windows2016-Image.id}"
    instance_type = "t2.micro"

    # VPC subnet
    subnet_id = "${element(split(":", data.terraform_remote_state.vpc-state.vpc-east-pub-subnet-ids), 0)}"

    # Security Group
    vpc_security_group_ids = ["${data.terraform_remote_state.vpc-state.vpc-east-SG-Public-Default-Win-id}"]

    # Public SSH key
    key_name = "${aws_key_pair.TF-Demo-Dev-Key.key_name}"

    # Private IP - static
    private_ip = "10.100.128.10"

    tags {
        Name      = "East-Bastion1"
        Project   = "${data.terraform_remote_state.vpc-state.project-name}"
        Terraform = "true"
        Description = "Windows Bastion Host"
    }
}
