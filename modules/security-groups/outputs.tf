/**
 * Terraform Demo
 * By: Mark
 */

output "SG-Public-Default-Win-id" {
    value = "${aws_security_group.SG-Public-Default-Win.id}"
}
