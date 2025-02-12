resource "openstack_compute_instance_v2" "vm" {
  count           = length(var.openstack_vmname)
  name            = var.openstack_vmname[count.index]
  image_id        = "${var.openstack_image_id}"
  flavor_id       = "${var.openstack_flavor_id}"
  key_pair        = var.openstack_keypair_name
  security_groups = var.openstack_sec_groups
  user_data       = "${var.cloud_init_data}"

  block_device {
    uuid                  = "${var.openstack_image_id}"
    source_type           = "image"
    volume_size           = "${var.openstack_boot_volume_size}"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "${var.openstack_net_name}"
    # Use the corresponding fixed IPv4 address from the list, if given
    # fixed_ip_v4 = var.fixed_ip_v4[count.index]
  }
  lifecycle {
    ignore_changes = [image_id]
  }
}

data "openstack_networking_port_v2" "vm_port" {
  count    = length(var.openstack_vmname)
  fixed_ip = openstack_compute_instance_v2.vm[count.index].access_ip_v4
}


