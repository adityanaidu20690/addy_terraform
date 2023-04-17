##create keypair###
resource "aws_key_pair" "deployer" {
  key_name   = "addy_new"
  public_key = file("${path.module}/id_rsa.pub")
}
##create security group##
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.port
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

##create a instance and attach the security group and key pair##
resource "aws_instance" "firstinstance" {
  ami           = var.ami
  instance_type = "t2.micro"
  # tenancy           = "host"
  availability_zone = "us-east-1b"
  key_name          = aws_key_pair.deployer.key_name
  tags = {
    name = "Hello"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
}
