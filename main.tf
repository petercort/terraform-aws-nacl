data "aws_vpcs" "nacl_vpc" {
  depends_on = [module.vpc]
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "nacl_subnet" {
  depends_on = [module.vpc]
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

resource "aws_network_acl_rule" "rule" {
  for_each       = { for index, rule in var.rules : rule.rule_number => rule }
  network_acl_id = aws_network_acl.main.id
  rule_number    = each.value.rule_number
  egress         = each.value.rule_type == "egress" ? true : false 
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}