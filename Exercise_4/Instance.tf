resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "dovekey"
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "Dove-web"
    Project = "Dove"
    Admin   = "Yana"
  }

  lifecycle {
    ignore_changes = [vpc_security_group_ids]
  }
}

resource "aws_ec2_instance_state" "dove-web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}