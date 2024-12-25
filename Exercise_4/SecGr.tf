resource "aws_security_group" "dove-sg" {
  name        = "dove-sg"
  description = "Security Group with dynamic rules"

  tags = {
    Name    = "dove-sg"
    Project = "dove"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules" {
  for_each = {
    for key, rule in local.updated_security_group_rules :
    key => rule if rule.type == "ingress"
  }

  security_group_id = aws_security_group.dove-sg.id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_blocks
  description       = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "engress_rules" {
  for_each = {
    for key, rule in local.updated_security_group_rules :
    key => rule if rule.type == "egress"
  }

  security_group_id = aws_security_group.dove-sg.id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_blocks != "::/0" ? each.value.cidr_blocks : null
  cidr_ipv6         = each.value.cidr_blocks == "::/0" ? each.value.cidr_blocks : null
  description       = each.value.description
}