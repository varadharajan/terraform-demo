provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "test_subnet" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "web_server" {
  ami = "ami-925144f2"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.test_subnet.id}"
}