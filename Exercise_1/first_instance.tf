provider "aws" {
  region = "us-west-1"
}

# Resource type and resource name
resource "aws_instance" "intro" {
  ami                    = "ami-038bba9a164eb3dc1"
  instance_type          = "t2.micro"
  availability_zone      = "us-west-1a"
  key_name               = "terraform_exs"
  vpc_security_group_ids = ["sg-020bae1ae523b335f"]
  tags = {
    Name    = "Terraform-Ex1"
    Project = "Terraform"
  }
}