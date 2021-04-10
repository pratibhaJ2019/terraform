data "template_file" "user_data" {
template = file("install_apache.sh")
}

resource "aws_instance" "FirstEC2" {
  key_name      = "newKey"
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  user_data = data.template_file.user_data.template
  disable_api_termination = true
  tags = {
    Name = "FirstEC2"
  }
}