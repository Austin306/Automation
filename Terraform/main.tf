resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-austin-aws-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "gw"{
    allocation_id = "${aws_eip.nat.id}"
    subnet_id     = "${aws_subnet.us-east-1a-public.id}"
    depends_on = ["aws_internet_gateway.default"]

    tags = {
        Name = "Gateway NAT"
    }
}


/*
  Public Subnet
*/
resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}

/*
  Private Subnet 1
*/
resource "aws_subnet" "us-east-1b-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_1}"
    availability_zone = "us-east-1b"

    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_route_table" "us-east-1b-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_route_table_association" "us-east-1b-private" {
    subnet_id = "${aws_subnet.us-east-1b-private.id}"
    route_table_id = "${aws_route_table.us-east-1b-private.id}"
}

/*
  Private Subnet 2
*/

resource "aws_subnet" "us-east-1c-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_2}"
    availability_zone = "us-east-1c"

    tags = {
        Name = "Private Subnet 2"
    }
}

resource "aws_route_table" "us-east-1c-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags = {
        Name = "Private Subnet 2"
    }
}

resource "aws_route_table_association" "us-east-1c-private" {
    subnet_id = "${aws_subnet.us-east-1c-private.id}"
    route_table_id = "${aws_route_table.us-east-1c-private.id}"
}

/*
  Private Subnet 3
*/
resource "aws_subnet" "us-east-1b-private-3" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_3}"
    availability_zone = "us-east-1b"

    tags = {
        Name = "Private Subnet 3"
    }
}

resource "aws_route_table" "us-east-1b-private-3" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags = {
        Name = "Private Subnet 3"
    }
}

resource "aws_route_table_association" "us-east-1b-private-3" {
    subnet_id = "${aws_subnet.us-east-1b-private-3.id}"
    route_table_id = "${aws_route_table.us-east-1b-private-3.id}"
}
