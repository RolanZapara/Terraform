#-----------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Rolan Zapara
#-----------------------------
#this is kind of test text to verify integration Github vs Jira
#this is test line for testing logging weeks/hours/minutes using message in commit :))

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  # we gonna use AMI for linux
  ami                    = "ami-076309742d466ad69"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user-data.tpl", {
    f_name       = "Rolan",
    l_name       = "Zapara",
    random_names = ["Vasya", "Petya", "Nick", "John"]
  })
  tags = {
    Name = "test name for webserver AWS instance"
  }
}

resource "aws_instance" "my_ubuntu_22_04" {
  count         = 2
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"

  tags = {
    Name    = "First test name for instance my_ubuntu_22_04"
    Owner   = "Rolan Zapara"
    Project = "Terraform lessons"
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
