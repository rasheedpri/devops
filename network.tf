# create vpc

resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/24"

}

resource "aws_subnet" "frontend_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.10.0.0/26"
  availability_zone = "us-west-2a"

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