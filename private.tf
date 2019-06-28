/*
  Private EC2 in private Subnet 1
*/
resource "aws_security_group" "private_ec2" {
    name = "vpc_private_ec2"
    description = "Private EC2 Instance."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.public_subnet_cidr}"]
    }
    egress { # MySQL
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr_2}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "Private EC2"
    }
}

resource "aws_instance" "Private_EC2" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1b"
    instance_type = "t2.small"
    vpc_security_group_ids = ["${aws_security_group.private_ec2.id}"]
    subnet_id = "${aws_subnet.us-east-1b-private.id}"
    source_dest_check = false
    depends_on = ["aws_db_instance.my_test_mysql"]

    tags = {
        Name = "Private EC2"
    }
    provisioner "file" {
    source      = "/home/austin/Terraform/sqlreq.sh"
    destination = "/tmp/sqlreq.sh"
  }
    provisioner "file" {
    source      = "/home/austin/Terraform/crud.py"
    destination = "/tmp/crud.py"
  }
    provisioner "file" {
    source      = "/home/austin/Terraform/terraform.tfstate"
    destination = "/tmp/terraform.tfstate"
  }
   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sqlreq.sh",
      "/tmp/sqlreq.sh args",
    ]
  }
}
