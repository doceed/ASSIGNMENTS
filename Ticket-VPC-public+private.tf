provider "aws" {
  region = "us-east-1"
}

# Create a vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    names = "myterraformvpc"
  }
}

# createa public subnet
resource "aws_subnet" "Publicsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
}

# create a private subnet
resource "aws_subnet" "Privatesubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
}

# create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

# create a route table for public subnet
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# route table associatin public subnet
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id = aws_subnet.Publicsubnet.id
  route_table_id = aws_route_table.PublicRT.id
}
