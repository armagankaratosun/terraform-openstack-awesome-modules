variable "security_groups" {
  description = "List of security group configurations"
  type        = list(object({
    name        = string
    description = string
    rules       = list(object({
      direction        = string
      protocol         = string
      remote_ip_prefix = string
      port_range_min   = number
      port_range_max   = number
      ethertype        = string
    }))
  }))
}