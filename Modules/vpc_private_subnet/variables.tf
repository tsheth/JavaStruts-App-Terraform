variable "name" {
  description = "Name to be used on subnet name tags"
  default     = ""
}

variable "vpc_id" {
  description = "ID of VPC to attach subnets to"
  default     = ""
}

variable "subnet_cidrs" {
  description = "A list of cidr blocks for the subnets"
  type        = "list"
  default     = []
}

variable "availability_zones" {
  description = "A list of availibility_zones to put the subnets in"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to subnets"
  type        = "map"
  default     = {}
}

/*variable "enable_nat_gateway" {
  description = "Should be true if you want to route the subnets to nat_gateway_ids"
  default = false
}

variable "nat_gateway_ids" {
  description = "List of nat gateway ids to route the subnet to"
  type        = "list"
  default     = []
}*/

variable "propagating_vgws" {
  description = "A list of VGWs the route table should propagate"
  type        = "list"
  default     = []
}

variable "route_table_ids" {
  description = "A list of route table ids to associate with the subnets. If none are provided route tables will be created."
  type        = "list"
}
