# create vpc

resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/24"

}

resource "aws_subnet" "subnet" {
  count             = 3
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = "us-west-2a"

  tags = {
    Name = var.tag[count.index]
  }

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}