resource "aws_security_group" "private-rds" {
    name = "vpc_private_rds"
    description = "An RDS in Private Subnet"

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr_1}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "Private-RDS"
    }
}

resource "aws_db_subnet_group" "rds-private-subnet-2" {
  name = "rds-private-subnet-group"
  subnet_ids = ["${aws_subnet.us-east-1c-private.id}","${aws_subnet.us-east-1b-private-3.id}"]
}
resource "aws_db_instance" "my_test_mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  name                        = "my_rds_mysql"
  username                    = "austin"
  password                    = "austin306"
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-private-subnet-2.name}"
  vpc_security_group_ids      = ["${aws_security_group.private-rds}"]

  tags = {
      Name = "Private-RDS-Private-2"
  }
}
output "rds_endpoint" {
  value = "${aws_db_instance.my_test_mysql.endpoint}"
}
output "rds_name" {
  value = "${aws_db_instance.my_test_mysql.name}"
}
output "rds_password" {
  value = "${aws_db_instance.my_test_mysql.password}"
}