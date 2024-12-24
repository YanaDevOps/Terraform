resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = "t3.micro"
  key_name               = "dovekey"
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = "us-west-1a"

  tags = {
    Name    = "Dove-web"
    Project = "Dove"
    Admin   = "Yana"
  }
}

resource "aws_ec2_instance_state" "dove-web-state" {
    instance_id = aws_instance.web.id
    state = "running"
}