
output "ATTACK_THIS_DOMAIN" {
  value = "${aws_cloudfront_distribution.struts_cf.domain_name}/struts2_2.3.15.1-showcase/showcase.action"
  description = "THIS DOMAIN NAME HAS TO BE USED TO ATTACK ON VICTIM."
}

output "victim_ssh_key_name" {
  value       = "${aws_key_pair.bastion_ssh.key_name}"
  description = "Private key is storated in /Script directory."
}

output "ELB_public_domain" {
  value = "${aws_elb.struts-pt-elb.dns_name}"
  description = "AWS ELB DNS name that is connected to vulnerable JAVA struts web application."
}
output "victim_private_ip" {
  value       = "${aws_instance.bastion_host.private_ip}"
  description = "Private ip address of victim server"
}

output "victim_public_ip" {
  value       = "${aws_eip.one.public_ip}"
  description = "Public IP address of Victim server"
}

output "victim_host_security_group_id" {
  value       = "${aws_security_group.bastion_host.id}"
  description = ""
}

output "victim_access_security_group_id" {
  value       = "${aws_security_group.bastion_access.id}"
  description = ""
}


output "vpc_id" {
  value       = "${module.vpc.vpc_id}"
  description = ""
}



