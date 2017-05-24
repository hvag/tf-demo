/**
 * Terraform Demo
 * By: Mark
 */

 provider "aws" {
      region = "${var.region}"
}

# Create Internet Gateway
resource "aws_internet_gateway" "IG" {
    vpc_id = "${var.vpc-id}"

    tags {
        Name      = "${var.name}"
        Project   = "${var.project-name}"
        Terraform = "true"
    }
}


# Create Route Table - Public
resource "aws_route_table" "VPC-Default-GW-Public" {
    vpc_id = "${var.vpc-id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.IG.id}"
    }

    tags {
        Name = "VPC-Default-GW-Public"
        Project   = "${var.project-name}"
        Terraform = "true"
    }
}


# Set Route Table Associations - Public
resource "aws_route_table_association" "VPC-public-assoc" {
    count          = "${length(split(":", var.pub-subnet-ids))}"
    subnet_id      = "${element(split(":", var.pub-subnet-ids), count.index)}"
    route_table_id = "${aws_route_table.VPC-Default-GW-Public.id}"
}
