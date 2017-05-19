/**
 * Terraform Demo
 * By: Mark
 */

output "vpc-id" {
    value = "${aws_vpc.vpc.id}"
}


output "vpc-network-address" {
    value = "${aws_vpc.vpc.cidr_block}"
}
