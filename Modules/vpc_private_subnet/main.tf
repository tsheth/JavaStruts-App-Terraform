/*resource "aws_route_table" "this" {
  count = "${length(var.route_table_ids) > 0 ? 0 : length(var.subnet_cidrs)}"
  vpc_id           = "${var.vpc_id}"
  propagating_vgws = ["${var.propagating_vgws}"]
  tags = "${merge(var.tags, map("Name", format("%s-private-%s", var.name, element(var.availability_zones, count.index))))}"
}*/
resource "aws_subnet" "this" {
  count             = "${length(var.subnet_cidrs)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.subnet_cidrs[count.index]}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  tags              = "${merge(var.tags, map("Name", format("%s-private-%s", var.name, element(var.availability_zones, count.index))))}"
}

/*resource "aws_route" "this_nat_gateway" {
  count = "${(length(var.route_table_ids) == 0 && var.enable_nat_gateway) ? length(var.subnet_cidrs) : 0}"
  route_table_id         = "${element(aws_route_table.this.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${var.nat_gateway_ids[count.index]}"
}*/
resource "aws_route_table_association" "this" {
  count          = "${length(var.subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.this.*.id, count.index)}"
  route_table_id = "${element(var.route_table_ids, count.index)}"
}
