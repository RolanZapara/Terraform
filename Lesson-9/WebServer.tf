#-----------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Rolan Zapara
#-----------------------------
#this is kind of test text to verify integration Github vs Jira

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  # we gonna use AMI for linux
  ami                    = "ami-076309742d466ad69"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip= `curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
  tags = {
    Name = "test name for webserver AWS instance"
  }
}

#next step to create security_group

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My first security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TAG WebServer Security Group"
  }
}
