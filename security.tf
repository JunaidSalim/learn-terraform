resource "aws_security_group" "devops_security_group" {
  name = "devops_security_group"
  description = "Allow HTTP and SSH traffic"
  vpc_id = aws_vpc.devops_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.devops_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.devops_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.devops_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = -1
}

resource "tls_private_key" "devops_ssh_key_algorithm" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "devops_ssh_key" {
  key_name = "devops_ssh_key"
  public_key = tls_private_key.devops_ssh_key_algorithm.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  content = tls_private_key.devops_ssh_key_algorithm.private_key_pem
  filename = "devops-ssh-key.pem"
  file_permission = "0400"
}