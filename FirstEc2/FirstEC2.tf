#data "template_file" "user_data" {
#template = file("install_apache.sh")
#}

#resource "aws_instance" "FirstEC2" {
#  key_name      = "newKey"
#  ami           = "ami-0742b4e673072066f"
#  instance_type = "t2.micro"
#  user_data = data.template_file.user_data.template
#  #disable_api_termination = true
#  tags = {
#   Name = "FirstEC2"
# }
#}
resource "aws_ebs_volume" "web_storage" {
    availability_zone  = aws_instance.FirstEC2.availability_zone
    type       = "gp2"
    size       = 2
    tags       = {
        Name = "web_storage"
    }
}
resource "aws_volume_attachment" "ebs_attach" {
    device_name  = "/dev/sdc"
    volume_id    = aws_ebs_volume.web_storage.id
    instance_id  = aws_instance.FirstEC2.id
    force_detach = true
}

#Mount EBS and Add data files.
resource "null_resource" "get_files" {
    connection {
        type  = "ssh"
        user  = "ec2-user"
        private_key  = file("/tmp/ec2Key/newKey.pem")
        host  = aws_instance.FirstEC2.public_ip
    }
    provisioner "remote-exec" {
        inline = [
                 "sudo rm /var/www/html/index.html",
                 "sudo mkfs -t ext4 /dev/sdc",
                 "sudo mount /dev/sdc /var/www/html",
                 "sudo rm -rf /var/www/html/*",
                 "sudo yum install git -y",
                 "sudo git clone https://github.com/chay2199/bootstrap_101.git /var/www/html/",
        ]
        
    }
    depends_on  = [aws_volume_attachment.ebs_attach]
}