data "aws_vpcs" "nacl_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "nacl_subnet" {
  for_each = toset(var.subnet_names)
  filter {
    name   = "tag:Name"
    values = [each.key]
  }
}

resource "aws_network_acl" "main" {
  vpc_id     = data.aws_vpcs.nacl_vpc.ids.0
  subnet_ids = [for subnets in data.aws_subnet.nacl_subnet : subnets.id]
  tags       = merge(tomap({ Name = var.name }), var.tags)
}

resource "aws_network_acl_rule" "ingress" {
  for_each       = { for index, ingress_rule in var.ingress_rules : ingress_rule.rule_number => ingress_rule }
  network_acl_id = aws_network_acl.main.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}


resource "aws_network_acl_rule" "egress" {
  for_each       = { for index, egress_rule in var.egress_rules : egress_rule.rule_number => egress_rule }
  network_acl_id = aws_network_acl.main.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}