/**
 * Terraform Demo
 * By: Mark
 */

 variable project-name { default = "TF-DEMO" }

variable east-region { default = "us-east-1" }
variable west-region { default = "us-west-2" }

variable vpc-east-network-address { default = "10.100.0.0/16" }
variable vpc-west-network-address { default = "10.200.0.0/16" } 

variable vpc-east-network-subnet { default = "10.100" }
variable vpc-west-network-subnet { default = "10.200" }
