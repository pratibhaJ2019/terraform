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

resource "aws_instance" "JenkinsServer" {
  ami           = "ami-096fda3c22c1c990a"
  instance_type = "t2.micro"

  tags = {
    Name = "JenkinsServer"
  }
}