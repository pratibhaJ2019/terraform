resource "aws_instance" "FirstEC2" {
  key_name      = "newKey"
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  user_data = "${file("install_apache.sh")}"
  termination_protection = true
  tags = {
    Name = "FirstEC2"
  }
}