
resource "aws_key_pair" "redmikey" {
  key_name   = "redmikey"
  public_key = "${var.PATH_TO_PUBLIC_KEY}"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  count         = "3"
  key_name      = "${aws_key_pair.redmikey.key_name}"
  tags = {
    Name = "TF-Server-${count.index + 1}"
  }
  # vpc subnets
  subnet_id = "${aws_subnet.tf-public-1.id}"
}

