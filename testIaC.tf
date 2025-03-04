# Configure AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# Define a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My VPC"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  type = "public"
  tags = {
    Name = "Public Subnet"
  }
}

# Create a security group allowing SSH access
resource "aws_security_group" "ssh_group" {
  name = "SSH Access"
  description = "Allow SSH connections"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance in the public subnet
resource "aws_instance" "web_server" {
  ami = "ami-0c55b155955555555"  # Replace with your desired AMI
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh_group.id]
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "Web Server"
  }
}

# Outputs for easy access
output "vpc_id" {
  value = aws_vpc.my_vpc.id
  description = "VPC ID"
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  description = "Public Subnet ID"
}
