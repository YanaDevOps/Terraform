variable "region" {
  description = "AWS region for instances"
  type        = string
  default     = "us-west-1"
}

variable "zone1" {
  description = "AWS zone for instances"
  type        = string
  default     = "us-west-1a"
}

variable "amiID" {
  description = "Ubuntu AMIs based on regions"
  type        = map(string)
  default = {
    us-west-1 = "ami-031af0979071399d0"
    us-west-2 = "ami-0fcae490e0416fb6f"
  }
}

variable "myIP" {
  description = "My IP address"
  type        = string
  default     = "88.156.137.126"
}

variable "security_group_rules" {
  description = "Rules for the security group"
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))

  default = {
    "ssh" = {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow SSH access from anywhere"
    }

    "http" = {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow http access from anywhere"
    }

    "all_outbound_IPv4" = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic for IPv4"
    }

    "all_outbound_IPv6" = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "::/0"
      description = "Allow all outbound traffic for IPv6"
    }
  }
}