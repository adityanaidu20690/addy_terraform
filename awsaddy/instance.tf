resource "aws_instance" "firstinstance" {
  ami           = "ami-069aabeee6f53e7bf"
  instance_type = "t2.micro"
  # tenancy           = "host"
  availability_zone = "us-east-1b"
  key_name          = aws_key_pair.deployer.key_name
  tags = {
    name = "Hello"
  }
  user_data              = file("${path.module}/addy.sh")
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
}


