data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "ec2_web_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.devops_security_group.id]
  associate_public_ip_address = true

  key_name = aws_key_pair.devops_ssh_key.key_name

  user_data = file("user_data.sh")

  tags = {
    Name = "EC2_Web_Server"
  }
}


resource "aws_instance" "ec2_database" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.devops_security_group.id]
  associate_public_ip_address = false

  key_name = aws_key_pair.devops_ssh_key.key_name

  tags = {
    Name = "EC2_DATABASE"
  }
}

output "public_webserver_ip" {
  description = "Public IP of Webserver"
  value = aws_instance.ec2_web_server.public_ip
}

output "private_database_ip" {
  description = "Private IP of Database"
  value = aws_instance.ec2_database.private_ip
}
