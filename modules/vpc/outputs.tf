/**
 * Terraform Demo
 * By: Mark
 */

output "vpc-id" {
    value = "${aws_vpc.vpc.id}"
}
