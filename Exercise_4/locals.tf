locals {
  updated_security_group_rules = merge(
    var.security_group_rules,
    {
      "ssh" = {
        type        = "ingress"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "${var.myIP}/32"
        description = "Allow SSH only from my IP"
      }
    }
  )
}