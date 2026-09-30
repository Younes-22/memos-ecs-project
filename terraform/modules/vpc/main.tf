

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = var.aws_az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
    Tier = "public"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet2_cidr
  availability_zone       = var.aws_az_2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
    Tier = "public"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = var.aws_az_1

  tags = {
    Name = "private-subnet-1"
    Tier = "private"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = var.aws_az_2

  tags = {
    Name = "private-subnet-2"
    Tier = "private"
  }
}

resource "aws_eip" "nat_1" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-1"
  }
}

resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "Nat Gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = var.internet_cidr
    nat_gateway_id = aws_nat_gateway.ngw_1.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}


