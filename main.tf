provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "test-terraform-1"
    key    = "web_service"
    region = "us-west-1"
  }
}

data "aws_ami" "ubuntu_1604" {
  most_recent = true

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }

  owners = ["099720109477"]
}

variable "html_content" {
  type = "string"
  default = "Hello World"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "test_gw" {
  vpc_id = "${aws_vpc.test_vpc.id}"
}

resource "aws_route_table" "test_route_table" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test_gw.id}"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_route_table_association" "test_route_table_association" {
  subnet_id      = "${aws_subnet.test_subnet.id}"
  route_table_id = "${aws_route_table.test_route_table.id}"
}

resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${aws_vpc.test_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami = "${data.aws_ami.ubuntu_1604.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.test_subnet.id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "${var.html_content}" > index.html
  nohup busybox httpd -f -p 80 &
  EOF
}

output "public_ip" {
  value = "${aws_instance.web_server.public_ip}"
}