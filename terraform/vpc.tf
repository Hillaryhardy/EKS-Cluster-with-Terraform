#vpc block used
#vpc prefix
resource "aws_vpc" "htapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

#vpc subnet
resource "aws_subnet" "htapp-subnet-1" {
  vpc_id            = aws_vpc.htapp-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

#provide internet on subnet
resource "aws_internet_gateway" "htapp-igw" {
  vpc_id = aws_vpc.htapp-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

#creates route table
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.htapp-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.htapp-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rtb"
  }
}

#creating a security group
resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.htapp-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}