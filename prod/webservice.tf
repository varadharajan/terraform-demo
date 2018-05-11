# Webservice 1
module "webservice_1" {
  source = "../modules/webservice"

  service_name = "webservice_1_${local.environment}"
  subnet = "${module.base.subnet_id}"
  vpc = "${module.base.vpc_id}"
  html_content = "Hello World - Service 1 - ${local.environment}"
}

# Webservice 2
module "webservice_2" {
  source = "../modules/webservice"

  service_name = "webservice_2_${local.environment}"
  subnet = "${module.base.subnet_id}"
  vpc = "${module.base.vpc_id}"
  html_content = "Hello World - Service 2 - ${local.environment}"
}
