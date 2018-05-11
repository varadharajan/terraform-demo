resource "aws_vpc" "test_vpc" {
  cidr_block = "${var.vpc_cidr}"
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
  cidr_block = "${var.subnet_cidr}"
}

resource "aws_route_table_association" "test_route_table_association" {
  subnet_id      = "${aws_subnet.test_subnet.id}"
  route_table_id = "${aws_route_table.test_route_table.id}"
}
