/**
 * Terraform Demo
 * By: Mark
 */

variable "region" {
    description = "In which AWS region should the VPC be created"
}

variable "name" {
    description = "Name of the VPC"
}

variable "cidr_block" {
    description = "VPC CIDR"
}