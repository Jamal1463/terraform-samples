resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.acerkey.key_name}"
  count         = "2"
  tags = {
    Name = "TF-Server-${count.index + 1}"
  }
  subnet_id = "${aws_subnet.acer-public-subnet-1.id}"
  # creating security groups
  vpc_security_group_ids = ["${aws_security_group.acer-ssh-sg.id}"]

}

resource "aws_key_pair" "acerkey" {
  key_name   = "acerkey"
  public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

