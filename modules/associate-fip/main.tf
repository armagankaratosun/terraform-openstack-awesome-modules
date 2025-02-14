# This templates assings floatingips that are allocated in the Openstack project.
# Normally, this has been done via the openstack-create-floatingip.tf file, which
# creates and assigns floating ips dynamically. But in some cases, there might be
# quoata issues (no more available ip) and unused ip addresses. Then you can use
# this template. You need to set the openstack_vm_floatingip (can be a list of IPs) 
# variable in the variables.tf.

data "openstack_networking_floatingip_v2" "vm-floatingip-vm" {
count = length(var.openstack_vm_floatingip)
address = (var.openstack_vm_floatingip[count.index])
}


resource "openstack_networking_floatingip_associate_v2" "vm-floatingip" {
  count = length(var.openstack_vm_floatingip)
  floating_ip = (data.openstack_networking_floatingip_v2.vm-floatingip-vm[count.index].address)
  port_id = (var.vm_port_id[count.index])
  }
