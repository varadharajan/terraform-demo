# Webservice 1
module "webservice_1" {
  source = "./modules/webservice"

  service_name = "webservice_1"
  subnet = "${aws_subnet.test_subnet.id}"
  vpc = "${aws_vpc.test_vpc.id}"
  html_content = "Hello World - Service 1"
}

output "webservice_1" {
  value = "${module.webservice_1.public_ip}"
}

# Webservice 2
module "webservice_2" {
  source = "./modules/webservice"

  service_name = "webservice_2"
  subnet = "${aws_subnet.test_subnet.id}"
  vpc = "${aws_vpc.test_vpc.id}"
  html_content = "Hello World - Service 2"
}

output "webservice_2" {
  value = "${module.webservice_2.public_ip}"
}
