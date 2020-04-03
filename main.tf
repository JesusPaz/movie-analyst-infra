provider "aws" {
  region  = "${var.region}"
  profile = "default"
}

data "template_file" "userdata" {
  template = "${file("scripts/userdata.sh")}"

  vars = {
    bucket_name = "${var.bucket_name}"
  }
}

resource "aws_instance" "jenkins_master" {

  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key}"
  user_data              = "${data.template_file.userdata.rendered}"
  iam_instance_profile   = "${aws_iam_instance_profile.rampup_instance_profile.name}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.rampup_sg_jenkins.id}"]

  tags = {
    Name        = "${var.instance_name}"
    Responsible = "${var.user_name}"
    Project     = "${var.project_name}"
  }
}
