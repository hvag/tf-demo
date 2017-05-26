/**
 * Terraform Demo
 * By: Mark
 */

output "pub-subnet-ids" {
    value = "${ join(":", aws_subnet.Pub.*.id) }"
}

output "priv1-subnet-ids" {
    value = "${ join(":", aws_subnet.Priv1.*.id) }"
}

output "priv2-subnet-ids" {
    value = "${ join(":", aws_subnet.Priv2.*.id) }"
}