provider "aws" {}

resource "aws_instance" "my_ubuntu_18_04" {
  count         = 3
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"

  tags = {
    Name    = "First test name for instance my_ubuntu_18_04"
    Owner   = "Rolan Zapara"
    Project = "Terraform lessons"
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

resource "aws_instance" "my_windows_server_2016" {
  count         = 1
  ami           = "ami-0a43463148e64d2d5"
  instance_type = "t2.micro"

  tags = {
    Name    = "First test name for instance my_windows_server_2016"
    Owner   = "Rolan Zapara"
    Project = "Terraform lessons"
  }
}
