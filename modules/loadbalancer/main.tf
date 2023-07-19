data "openstack_networking_network_v2" "loadbalancer-network" {
   name = var.openstack_net_name
}

data "openstack_networking_subnet_v2" "loadbalancer-network-subnet" {
   network_id = data.openstack_networking_network_v2.loadbalancer-network.id
}

data "openstack_networking_floatingip_v2" "lb-floatingip" {
address = var.openstack_lb_floatingip
}

resource "openstack_lb_loadbalancer_v2" "loadbalancer" {
  name = var.openstack_lb_name
  vip_network_id = data.openstack_networking_network_v2.loadbalancer-network.id
}

resource "openstack_lb_listener_v2" "listener" {
  count           = length(var.openstack_listener_name)
  name            = var.openstack_listener_name[count.index]
  protocol        = var.openstack_listener_protocol[count.index]
  protocol_port   = var.openstack_listener_port[count.index]
  loadbalancer_id = openstack_lb_loadbalancer_v2.loadbalancer.id
}

resource "openstack_lb_pool_v2" "pool" {
  count       = length(var.openstack_pool_name)
  name        = var.openstack_pool_name[count.index]
  protocol    = var.openstack_pool_protocol[count.index]
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.listener.*.id
}

resource "openstack_lb_member_v2" "members_http" {
  count = var.openstack_vm_count
  name          = (openstack_compute_instance_v2.vm[count.index].name)
  pool_id       = (openstack_lb_pool_v2.rancher-admin-http.id)
  address       = (openstack_compute_instance_v2.vm[count.index].access_ip_v4)
  protocol_port = 80
}
resource "openstack_lb_member_v2" "members_https" {
  count = var.openstack_vm_count
  name          = (openstack_compute_instance_v2.vm[count.index].name)
  pool_id       = (openstack_lb_pool_v2.rancher-admin-https.id)
  address       = (openstack_compute_instance_v2.vm[count.index].access_ip_v4)
  protocol_port = 443
}

resource "openstack_networking_floatingip_associate_v2" "lb-floatingip-associate" {
  floating_ip = (data.openstack_networking_floatingip_v2.lb-floatingip.address)
  port_id = "${openstack_lb_loadbalancer_v2.rancher-admin-lb.vip_port_id}"
depends_on = [resource.openstack_lb_loadbalancer_v2.rancher-admin-lb]
}