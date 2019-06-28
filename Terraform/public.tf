resource "aws_security_group" "public_ec2" {
    name = "vpc_public_ec2"
    description = "An EC2 Instance in Public Subnet"

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { #Private EC2
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr_1}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "Public-EC2"
    }
}

resource "aws_instance" "public-ec2" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "t2.small"
    vpc_security_group_ids = ["${aws_security_group.public_ec2.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags = {
        Name = "Public EC2"
    }
}

