output "subnets" {
  description = "List of IDs of subnets"
  value       = "${aws_subnet.this.*.id}"
}

output "cidr_blocks" {
  description = "List of cidr_blocks of subnets"
  value       = "${aws_subnet.this.*.cidr_block}"
}

output "route_table_ids" {
  description = "List of IDs of subnet route tables"
  value       = "${var.route_table_ids}"
}
