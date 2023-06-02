## terraform-aws-nacl

This module mirrors the functionality of my terraform-aws-security-group module, creating the nacl first, and then creating and attaching the rules.  

This module takess vpc and subnet names instead of ids. 

Usage: 
```
module "nacl" {
  source        = "git::https://github.com/petercort/terraform-aws-nacl"
  name          = "Web-nacl"
  vpc_name      = "dev-workload-vpc"
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
  subnet_names  = ["dev-workload-vpc-1a-pvtsub-1"]
  tags          = { env = "dev"}
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

|                   Name                           |                  Source            | Version |
|--------------------------------------------------|------------------------------------|---------|
| <a name="module_nacl"></a> [nacl](#module\_nacl) | tedilabs/network/aws//modules/nacl |  0.27.0 |

## Resources

No resources.

## Inputs

|             Name           |                                                                      Description                                                                                                           |      Type    |         Default        | Required |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|------------------------|----------|
| name                       | Desired name for the network ACL resources.                                                                                                                                                | string       |   n/a                  |    yes   |
| vpc_id                     | The ID of the associated VPC.                                                                                                                                                              | string       |   n/a                  |    yes   |
| egress_rules               | A map of egress rules in a network ACL. Use the key of map as the rule number.                                                                                                             | map(map(any))|   {}	                  |    no    |
| ingress_rules              | A map of ingress rules in a network ACL. Use the key of map as the rule number.                                                                                                            | map(map(any))|	 {}	                  |    no    |
| module_tags_enabled        |Whether to create AWS Resource Tags for the module informations.                                                                                                                            | bool         |   true                 |    no    |
| resource_group_description | The description of Resource Group.                                                                                                                                                         | string       | "Managed by Terraform."|    no    |
| resource_group_enabled     | Whether to create Resource Group to find and group AWS resources which are created by this module.                                                                                         | bool         |   true	              |    no    |
| resource_group_name        | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with AWS or aws. | string       |    ""                  |    no    |
| subnets                    | A list of subnet IDs to apply the ACL to.                                                                                                                                                  | list(string) |	  []                  |    no    |
| tags                       | A map of tags to add to all resources.                                                                                                                                                     | map(string)  |   {}                   |    no    |

## Outputs

|                               Name                             | Description |
|----------------------------------------------------------------|-------------|
| <a name="output_nacl_arn"></a> [nacl\_arn](#output\_nacl\_arn) |      n/a    |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
