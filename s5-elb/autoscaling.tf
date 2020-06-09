resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.allow-ssh.id}"]
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = ["${aws_subnet.tf-public-1.id}", "${aws_subnet.tf-public-2.id}"]
  launch_configuration      = "${aws_launch_configuration.example-launchconfig.id}"
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = ["${aws_elb.my-elb.name}"]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "tf-elb-instance"
    propagate_at_launch = true
  }
}

