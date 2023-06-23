
resource "aws_network_acl" "main" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
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