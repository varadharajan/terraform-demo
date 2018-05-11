module "base" {
  source = "../modules/base"

  vpc_cidr = "10.1.0.0/16"
  subnet_cidr = "10.1.1.0/24"
}
