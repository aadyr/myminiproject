resource "aws_instance" "instances" {
  count = 2
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids = "sg-d6a22a98"
  subnet_id = "subnet-50adb50b"

  tags = {
    Name = "aadywebserver-${count.index + 1}"
  }
}

resource "aws_instance" "instance2" {
  ami           = "ami-0fc61db8544a617ed"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  count         = 1
  associate_public_ip_address = "true"
  vpc_security_group_ids = "sg-d6a22a98"
  subnet_id = "subnet-50adb50b"

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

