/**
 * Terraform Demo
 * By: Mark
 */

output "east-region" {
    value = "${data.terraform_remote_state.vpc-state.east-region}"
}

output "windows2016-Image" {
    value = "${aws_ami_copy.windows2016-Image.id}"
}

output "east-key-pair-id" {
    value = "${aws_key_pair.TF-Demo-Dev-Key.id}"
}

output "east-SG-BastionToPrivate-id" {
    value = "${aws_security_group.SG-BastionToPrivate.id}"
}
