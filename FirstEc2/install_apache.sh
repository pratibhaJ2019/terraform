#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
#echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
sudo mkdir tmp