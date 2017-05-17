/**
 * Terraform Demo
 * By: Mark
 */

output "vpc_name" {
    value = "${aws_vpc.TF-DEMO.name}"
}