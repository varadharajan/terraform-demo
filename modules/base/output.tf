output "vpc_id" {
  value = "${aws_vpc.test_vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.test_subnet.id}"
}