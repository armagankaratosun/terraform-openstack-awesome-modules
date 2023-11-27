resource "openstack_networking_network_v2" "vlan_network" {
  count = var.network_type == "vlan" ? length(var.net_name) : 0

  name              = var.net_name[count.index]
  tenant_id         = var.tenant_id
  mtu               = var.mtu
  admin_state_up    = var.admin_state_up 
  shared            = var.shared
  external          = var.external

# Define network_type spesific variables
  segments {
      network_type               = var.network_type
      physical_network           = var.physical_network[count.index]
      segmentation_id            = var.segmentation_id[count.index]
  }
}

resource "openstack_networking_network_v2" "flat_network" {
  count = var.network_type == "flat" ? length(var.net_name) : 0

  name              = var.net_name[count.index]
  tenant_id         = var.tenant_id
  mtu               = var.mtu
  admin_state_up    = var.admin_state_up 
  shared            = var.shared
  external          = var.external

# Define network_type spesific variables
  segments {
      network_type               = var.network_type
      physical_network           = var.physical_network[count.index]
  }
}

resource "openstack_networking_network_v2" "vxlan_geneve_gre_network" {
  count = var.network_type != "flat" && var.network_type != "vlan"  ? length(var.net_name) : 0

  name              = var.net_name[count.index]
  tenant_id         = var.tenant_id
  mtu               = var.mtu
  admin_state_up    = var.admin_state_up 
  shared            = var.shared
  external          = var.external

# Define network_type spesific variables
  segments {
      network_type               = var.network_type
      segmentation_id            = var.segmentation_id[count.index]
  }
}

resource "openstack_networking_subnet_v2" "subnet" {
  count = length(var.net_name)

  # Define subnet attributes here, such as name, CIDR, gateway IP, etc.
  name             = "subnet-${var.net_name[count.index]}"
  ip_version       = var.ip_version
  cidr             = var.subnet_cidr[count.index]
  gateway_ip       = var.subnet_gateway[count.index]
  enable_dhcp      = var.enable_dhcp
  dns_nameservers  = var.dns_nameservers
  
  # Determine the network_id based on var.network_type
  network_id = (
    var.network_type == "vlan" ? openstack_networking_network_v2.vlan_network[count.index].id :
    var.network_type == "flat" ? openstack_networking_network_v2.flat_network[count.index].id :
    openstack_networking_network_v2.vxlan_geneve_gre_network[count.index].id
  )
}