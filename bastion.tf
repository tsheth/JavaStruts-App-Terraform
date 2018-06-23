data "template_file" "user_data" {
  template = "${file("user_data.sh")}"

}

resource "aws_instance" "bastion_host" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.bastion_host.id}"]
  subnet_id              = "${module.mgmt_subnets.subnets[0]}"
  user_data = "${data.template_file.user_data.rendered}"
  key_name = "${aws_key_pair.bastion_ssh.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  tags = "${merge(
    local.default_tags,
    map(
      "Name", "Struts-WebPT-Tejas"
    )
  )}"
}

resource "aws_security_group" "bastion_host" {
  name        = "bastion_host"
  description = "Allow connection for host"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    local.default_tags,
    map(
      "Name", "struts_pt-demo_tejas"
    )
  )}"
}

resource "aws_security_group" "bastion_access" {
  name        = "bastion_access"
  description = "allow access from bastion host"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion_host.id}"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion_host.id}"]
  }
  tags = "${merge(
    local.default_tags,
    map(
      "Name", "struts_access"
    )
  )}"
}

resource "aws_key_pair" "bastion_ssh" {
  key_name   = "bastion_ssh"
  public_key = "${var.bastion_ssh_key}"
}


resource "aws_eip" "one" {
  instance = "${aws_instance.bastion_host.id}"
  vpc      = true


}
