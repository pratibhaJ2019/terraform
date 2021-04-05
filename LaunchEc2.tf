terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_key_pair" "jenkinsKey" {
  key_name   = "jenkinsKey"
  public_key = file("key.pub")
}

resource "aws_instance" "JenkinsServer" {
  ami           = "ami-096fda3c22c1c990a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    sg-05c672069a93e2ebc
  ]

  tags = {
    Name = "JenkinsServer"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
    host        = self.public_ip
  }
}



