## terraform-aws-nacl

This module mirrors the functionality of my terraform-aws-security-group module, creating the nacl first, and then creating and attaching the rules.  

This module takes vpc and subnet names instead of ids. 

Usage: 
```
module "nacl" {
  source        = "git::https://github.com/petercort/terraform-aws-nacl"
  name          = "Web-nacl"
  vpc_name      = "my-workload-vpc"
  egress_rules  = [{
        rule_number = "200"
        from_port = "443"
        to_port = "443"
        cidr_block = "0.0.0.0/0"
        rule_action = "allow"
        protocol = "tcp"
      },{
        rule_number = "201"
        from_port = "80"
        to_port = "80"
        cidr_block = "0.0.0.0/0"
        rule_action = "allow"
        protocol = "tcp"
      }
  ]
  ingress_rules = [{
        rule_number = "202"
        from_port = "443"
        to_port = "443"
        cidr_block = "0.0.0.0/0"
        rule_action = "allow"
        protocol = "tcp"
      },{
        rule_number = "203"
        from_port = "80"
        to_port = "80"
        cidr_block = "0.0.0.0/0"
        rule_action = "allow"
        protocol = "tcp"
      }]
  subnet_names  = ["az1a-pvtsub-1"]
  tags          = { env = "dev"}
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_network_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_subnet.nacl_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpcs.nacl_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | n/a | <pre>list(object({<br>    rule_number = string<br>    from_port   = optional(string, null)<br>    to_port     = optional(string, null)<br>    protocol    = optional(string, "-1")<br>    cidr_block  = optional(string, "0.0.0.0/0")<br>    rule_action = optional(string, "allow")<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | n/a | <pre>list(object({<br>    rule_number = string<br>    from_port   = optional(string, null)<br>    to_port     = optional(string, null)<br>    protocol    = optional(string, "-1")<br>    cidr_block  = optional(string, "0.0.0.0/0")<br>    rule_action = optional(string, "allow")<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | name of the nacl. | `string` | `null` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | List of subnets to attach nacl to. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the nacl. | `map(string)` | `{}` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC to attach to. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the network ACL. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the network ACL. |
<!-- END_TF_DOCS -->