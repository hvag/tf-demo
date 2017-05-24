/**
 * Terraform Demo
 * By: Mark
 */

output "pub-subnet-ids" {
    value = "${ join(":", aws_subnet.Pub.*.id) }"
}
