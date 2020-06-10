resource "aws_vpc" "acer-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "tf-acer-vpc"
  }
}
## Subnets Creation of Public & Private

resource "aws_subnet" "acer-public-subnet-1" {
  vpc_id                  = "${aws_vpc.acer-vpc.id}"
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "acer-public-subnet-1"
  }
}

resource "aws_subnet" "acer-private-subnet-1" {
  vpc_id                  = "${aws_vpc.acer-vpc.id}"
  cidr_block              = "10.0.9.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "acer-private-subnet-1"
  }
}

## Creating Internet Gateway

resource "aws_internet_gateway" "acer-igw" {
  vpc_id = "${aws_vpc.acer-vpc.id}"
  tags = {
    Name = "acer-tf-igw"
  }
}

## Creating Route Tables

resource "aws_route_table" "acer-rtb" {
  vpc_id = "${aws_vpc.acer-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.acer-igw.id}"
  }
  tags = {
    Name = "acer-public-route"
  }
}

## Associating Route Tables

resource "aws_route_table_association" "acer-public-subnet-1-a" {
  subnet_id      = "${aws_subnet.acer-public-subnet-1.id}"
  route_table_id = "${aws_route_table.acer-rtb.id}"
}

