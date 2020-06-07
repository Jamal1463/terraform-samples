# Creating VPC

resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "tf_vpc"
  }
}

# Subnets

resource "aws_subnet" "tf-public-1" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "tf-public-1"
  }
}

resource "aws_subnet" "tf-public-2" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "tf-public-2"
  }
}

resource "aws_subnet" "tf-public-3" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1c"
  tags = {
    Name = "tf-public-3"
  }
}

# Creating private subnets

resource "aws_subnet" "tf-private-1" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "tf-private-1"
  }
}

resource "aws_subnet" "tf-private-2" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "tf-private-2"
  }
}

resource "aws_subnet" "tf-private-3" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1c"
  tags = {
    Name = "tf-private-3"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = "${aws_vpc.example.id}"
  tags = {
    Name = "my-tf-igw"
  }
}

# Creating Route Tables

resource "aws_route_table" "tf-public-route" {
  vpc_id = "${aws_vpc.example.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf-igw.id}"
  }
  tags = {
    Name = "tf-public-route"
  }
}

# route association

resource "aws_route_table_association" "tf-public-1-a" {
  subnet_id      = "${aws_subnet.tf-public-1.id}"
  route_table_id = "${aws_route_table.tf-public-route.id}"
}

resource "aws_route_table_association" "tf-public-2-a" {
  subnet_id      = "${aws_subnet.tf-public-2.id}"
  route_table_id = "${aws_route_table.tf-public-route.id}"
}

resource "aws_route_table_association" "tf-public-3-a" {
  subnet_id      = "${aws_subnet.tf-public-2.id}"
  route_table_id = "${aws_route_table.tf-public-route.id}"
}


