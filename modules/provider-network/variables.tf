variable "net_name" {
    description = "Name of the network created, can be a list of strings"
    type       = list(string)
}

variable "network_type" {
    description = "The type of network (e.g., local, flat, vlan, gre, vxlan, geneve)"
    type        = string
}

variable "tenant_id" {
    description = "id of the admin tenant"
    type        = string 
}

variable "physical_network" {
    description = "value"
    type        = list(string)
}

variable "segmentation_id" {
    description = "vlan id"
    type = list(string)
    default = [ "" ]
}

variable "mtu" {
    description = "value"
    type = string
    default = "1500"
}

variable "admin_state_up" {
    description = "The administrative state of the network. Acceptable values are 'true' and 'false'. Changing this value updates the state of the existing network."
    type        = bool
}

variable "shared" {
    description = "Specifies whether the network resource can be accessed by any tenant or not."
    type        = bool
}

variable "external" {
    description = "Specifies whether the network resource has the external routing. Valid values are true and false."
    type        = bool
}

# Subnet variables

variable "subnet_cidr" {
    description = "value"
    type = list(string)
}

variable "ip_version" {
    description = "value"
    type = number
    default = 4
  
}

variable "subnet_gateway" {
    description = "value"
    type = list(string)
}

variable "enable_dhcp" {
    description = "value"
    type = bool
    default = true
}

variable "dns_nameservers" {
    description = "value"
    type = list(string)
    default = [ "" ]
}