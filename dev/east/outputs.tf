/**
 * Terraform Demo
 * By: Mark
 */

output "east-region" {
    value = "${data.terraform_remote_state.vpc-state.east-region}"
}

output "aws_ami" {
    value = "${data.aws_ami.windows2016-image.id}"
}
