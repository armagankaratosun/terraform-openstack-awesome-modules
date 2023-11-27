resource "openstack_networking_secgroup_v2" "security_group" {
  count = length(var.security_groups)

  name        = var.security_groups[count.index].name
  description = var.security_groups[count.index].description
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule" {
  count = length(flatten([for sg in var.security_groups : sg.rules]))

  security_group_id = openstack_networking_secgroup_v2.security_group[count.index % length(openstack_networking_secgroup_v2.security_group)].id
  direction        = var.security_groups[count.index % length(var.security_groups)].rules[count.index % length(var.security_groups[count.index % length(var.security_groups)].rules)].direction
  protocol         = var.security_groups[count.index % length(var.security_groups)].rules[count.index % length(var.security_groups[count.index % length(var.security_groups)].rules)].protocol
  remote_ip_prefix = var.security_groups[count.index % length(var.security_groups)].rules[count.index % length(var.security_groups[count.index % length(var.security_groups)].rules)].remote_ip_prefix
  port_range_min   = var.security_groups[count.index % length(var.security_groups)].rules[count.index % length(var.security_groups[count.index % length(var.security_groups)].rules)].port_range_min
  port_range_max   = var.security_groups[count.index % length(var.security_groups)].rules[count.index % length(var.security_groups[count.index % length(var.security_groups)].rules)].port_range_max
  ethertype        = var.security_groups[count.index % length(var.security_groups)].rules[count.index % length(var.security_groups[count.index % length(var.security_groups)].rules)].ethertype
}