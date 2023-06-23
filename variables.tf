variable "name" {
  type        = string
  description = "name of the nacl."
  default     = null
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC to attach to."
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids to attach nacl to."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the nacl."
  default     = {}
}

variable "rules" {
  type = list(object({
    rule_number = string
    rule_type   = string
    from_port   = optional(string, null)
    to_port     = optional(string, null)
    protocol    = optional(string, "-1")
    cidr_block  = optional(string, "0.0.0.0/0")
    rule_action = optional(string, "allow")
  }))
  default = []
}