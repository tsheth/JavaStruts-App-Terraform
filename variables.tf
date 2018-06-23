locals {
  default_tags = {
    Environment = "${var.environment_tag_prefix}-${var.environment_tag_suffix[terraform.workspace]}"
    Terraform   = "True"
  }

  environment_list = ["dev", "qa"]

}


variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-2"
}

variable "instance_username" {
  default = "ubuntu"
}

variable "path_to_private_key" {
  default = "/Scripts/TM-Tejas-Keypair.pem"
}

variable "AMIS"{
  type = "map"
  default = {
    us-east-2 = "ami-b0f7cbd5"
    us-west-2 = "ami-d097e9a8"
    eu-west-1 = "ami-2c645a55"
  }
}

variable "environment_tag_prefix" {
  default = "Tejas-Struts-PT"
}

variable "environment_tag_suffix" {
  type = "map"
}

variable "alachua_public_cidr_block" {}
variable "bastion_ssh_key" {}

variable "aws_profile" {
  description = "Profile in ~/.aws/credentials with credentials for terraform user. Should be overridden by jenkins provided credentials."
  default     = ""
}

variable "vpc_name" {
  type = "map"
}

variable "vpc_public_subnet_cidr" {
  type = "map"
}

variable "vpc_mgmt_subnet_cidr" {
  type = "map"
}

variable "vpc_app_subnet_cidr" {
  type = "map"
}

variable "vpc_services_subnet_cidr" {
  type = "map"
}

variable "vpc_masterdb_subnet_cidr" {
  type = "map"
}

variable "env_url_prefix" {
  type = "map"
}

variable "routing_cluster_name" {
  default = "routing"
}



