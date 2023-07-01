resource "aws_instance" "instances" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "g-09b913b1a06a3a22e"
  subnet_id = "subnet-0c367963f6cb16292"

  tags = {
    Name = "aadywebserver-1"
  }
}
resource "aws_instance" "instance1" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "sg-09b913b1a06a3a22e"
  subnet_id = "subnet-0c367963f6cb16292"

  tags = {
    Name = "aadywebserver-2"
  }
}
resource "aws_instance" "instance2" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "sg-09b913b1a06a3a22e"
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

