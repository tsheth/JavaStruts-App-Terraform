data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name[terraform.workspace]}"
  cidr = "10.132.0.0/16"

  azs             = ["${slice(data.aws_availability_zones.available.names,0,3)}"]
  private_subnets = "${var.vpc_services_subnet_cidr[terraform.workspace]}"
  public_subnets  = "${var.vpc_public_subnet_cidr[terraform.workspace]}"

  enable_s3_endpoint = true

  create_database_subnet_group = false
  enable_dns_hostnames         = true
  enable_dns_support           = true
  enable_nat_gateway           = true

  map_public_ip_on_launch = false

  tags = "${local.default_tags}"
}

module "mgmt_subnets" {
  source             = "./Modules/vpc_private_subnet"
  name               = "mgmt"
  vpc_id             = "${module.vpc.vpc_id}"
  subnet_cidrs       = "${var.vpc_mgmt_subnet_cidr[terraform.workspace]}"
  availability_zones = ["${slice(data.aws_availability_zones.available.names,0,3)}"]
  tags               = "${local.default_tags}"
  route_table_ids    = "${module.vpc.public_route_table_ids}"
}

module "app_subnets" {
  source             = "./Modules/vpc_private_subnet"
  name               = "app"
  vpc_id             = "${module.vpc.vpc_id}"
  subnet_cidrs       = "${var.vpc_app_subnet_cidr[terraform.workspace]}"
  availability_zones = ["${slice(data.aws_availability_zones.available.names,0,3)}"]
  tags               = "${local.default_tags}"
  route_table_ids    = "${module.vpc.private_route_table_ids}"
}

/*module "services_subnets" {
  source = "./Modules/vpc_private_subnet"
  name = "services"
  vpc_id = "${module.vpc.vpc_id}"
  subnet_cidrs = "${var.vpc_services_subnet_cidr[terraform.workspace]}"
  availability_zones = ["${slice(data.aws_availability_zones.available.names,0,3)}"]
  tags = "${local.default_tags}"
  enable_nat_gateway = true
  nat_gateway_ids = "${module.vpc.natgw_ids}"
}*/

module "masterdb_subnets" {
  source             = "./Modules/vpc_private_subnet"
  name               = "masterdb"
  vpc_id             = "${module.vpc.vpc_id}"
  subnet_cidrs       = "${var.vpc_masterdb_subnet_cidr[terraform.workspace]}"
  availability_zones = ["${slice(data.aws_availability_zones.available.names,0,3)}"]
  tags               = "${local.default_tags}"
  route_table_ids    = "${module.vpc.private_route_table_ids}"
}
