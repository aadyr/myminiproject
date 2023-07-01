resource "aws_instance" "instances" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "group3-vpc"
  subnet_id = "subnet-0c367963f6cb16292"

  tags = {
    Name = "aadywebserver-1"
  }
}
resource "aws_instance" "instances" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "group3-vpc"
  subnet_id = "subnet-0c367963f6cb16292"

  tags = {
    Name = "aadywebserver-2"
  }
}
resource "aws_instance" "instances" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "group3-vpc"
  subnet_id = "subnet-0c367963f6cb16292"

  user_data = <<EOF
     #!/bin/bash
     sudo yum update -y
     sudo yum install pip -y
     sudo python3 -m pip install --user ansible
     EOF

  tags = {
    Name = "aadyansible-server"
  }
}
resource "aws_vpc" "aady_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "aady_vpc"
  }
}

resource "aws_subnet" "aady_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-northeast-1"

  tags = {
    Name = "aady_subnet"
  }
}

resource "aws_security_group" "allow_aady" {
  name        = "allow_aady"
  description = "Allow aady inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "aady TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "aady_allow_tls"
  }
}
