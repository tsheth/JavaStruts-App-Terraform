environment_tag_prefix = "TrendMicro-Tejas-"
bastion_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCRdPqy3pHts9bzOKnoJ+J9QN94ydrapFvgm4L1njU09/VrlgvniQd0OtNYMPLWWAU3Y36VuUTF6jK3nWJFNNTEDwRsCMQvvO9C+BMYEm9WQBtqVeeajrslwHN9pNkUx7pCCwU6myxEuFm/LxcUPjoLST2POt/QrdZSk2ReUG29gGO5UdP2ckhk3xtLUH9wvqYwTdSx9SC6MQV16f1Z0i1rBUMxiaYHG6dgQBdTANFv8+Y8ixCKGH1PFl59NAGvxN5EB+YwhJs6dT7zhdo2qp5iXIc959fmHU6Jn/Swg0Tgfj4ixH921C5gXyt8tPwRs/HC98VaVG4xrsgzJP0PBDt9 imported-openssh-key"

path_to_private_key = "Scripts/TM-Tejas-Keypair.pem"
instance_username = "ubuntu"

environment_tag_suffix = {
  dev = "Dev"
  default = "Default"
  qa = "QA"
}

vpc_name = {
  dev = "Struts-Tejas-Dev"
  default = "Struts-Tejas-Default"
  qa = "Struts-Tejas-QA"
}
vpc_public_subnet_cidr = {
  dev = ["10.132.0.0/26", "10.132.1.0/26", "10.132.2.0/26"]
  default = ["10.132.0.0/26", "10.132.1.0/26", "10.132.2.0/26"]
  qa = ["10.132.18.0/26", "10.132.19.0/26", "10.132.20.0/26"]
}
vpc_mgmt_subnet_cidr = {
  dev = ["10.132.0.192/26", "10.132.1.192/26", "10.132.2.192/26"]
  default = ["10.132.0.192/26", "10.132.1.192/26", "10.132.2.192/26"]
  qa = ["10.132.18.192/26", "10.132.19.192/26", "10.132.20.192/26"]
}
vpc_app_subnet_cidr = {
  dev = ["10.132.0.64/26", "10.132.1.64/26", "10.132.2.64/26"]
  default = ["10.132.0.64/26", "10.132.1.64/26", "10.132.2.64/26"]
  qa = ["10.132.18.64/26", "10.132.19.64/26", "10.132.20.64/26"]
}
vpc_services_subnet_cidr = {
  dev = ["10.132.3.0/24", "10.132.4.0/24", "10.132.5.0/24"]
  default = ["10.132.3.0/24", "10.132.4.0/24", "10.132.5.0/24"]
  qa = ["10.132.21.0/24", "10.132.22.0/24", "10.132.23.0/24"]
}
vpc_masterdb_subnet_cidr = {
  dev = ["10.132.6.0/24", "10.132.7.0/24", "10.132.8.0/24"]
  default = ["10.132.6.0/24", "10.132.7.0/24", "10.132.8.0/24"]
  qa = ["10.132.24.0/24", "10.132.25.0/24", "10.132.26.0/24"]
}
env_url_prefix = {
  dev = "dev"
  default = "default"
  qa  = "qa"
}

