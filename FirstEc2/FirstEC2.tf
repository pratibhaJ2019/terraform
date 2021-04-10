resource "aws_instance" "FirstEC2" {
  key_name      = "newKey"
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"

  tags = {
    Name = "FirstEC2"
  }
}