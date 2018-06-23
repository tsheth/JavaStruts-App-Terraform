
resource "aws_elb" "struts-pt-elb" {
  name               = "struts-pt-elb"
  subnets = ["${module.mgmt_subnets.subnets[0]}", "${module.mgmt_subnets.subnets[1]}", "${module.mgmt_subnets.subnets[2]}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 12
    target              = "HTTP:8080/"
    interval            = 30
  }

  instances                   = ["${aws_instance.bastion_host.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name = "struts-pt-loadbalancer"
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "struts-pt-loadbalancer_sg"
  description = "Allow connection for host"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
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
      "Name", "Struts_LB_tejas"
    )
  )}"
}


