resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  count = "3"
  tags = {
    Name = "Redhat_Server_${count.index + 1}"
  }

}

