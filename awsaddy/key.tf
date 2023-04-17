resource "aws_key_pair" "deployer" {
  key_name   = "addy_new"
  public_key = file("${path.module}/id_rsa.pub")
}
