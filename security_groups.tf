// Security group
resource "aws_security_group" "rampup_sg_jenkins" {
  name        = "rampup_sg_jenkins"
  description = "Allow all needed ports for Jenkins"
  vpc_id      = "${var.vpc_id}"
}


// Rules for security group
resource "aws_security_group_rule" "rampup_sg_jenkins_rule_jenkins" {
  security_group_id = "${aws_security_group.rampup_sg_jenkins.id}"
  type              = "ingress"
  from_port         = "${var.jenkins_port}"
  to_port           = "${var.jenkins_port}"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rampup_sg_jenkins_rule_ssh" {
  security_group_id = "${aws_security_group.rampup_sg_jenkins.id}"
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "perf_explorer_ec2_sl_rule_outbound" {
  security_group_id = "${aws_security_group.rampup_sg_jenkins.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
