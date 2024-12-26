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

  # Copies the web.sh file to /var/www/html/
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("dovekey")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }

  lifecycle {
    ignore_changes = [vpc_security_group_ids]
  }
}

resource "aws_ec2_instance_state" "dove-web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "web_public_IP" {
  description = "Public IP of the instance"
  value       = aws_instance.web.public_ip
}

output "web_private_IP" {
  description = "Public IP of the instance"
  value       = aws_instance.web.private_ip
}