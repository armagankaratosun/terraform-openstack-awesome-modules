variable openstack_vm_floatingip { 
   type = list
   description = "fixed public ip address for the vm, can be a list of ips"
}
variable "vm_port_id" {
    type = list
    description = "port ids of the vms that will be assigned with a floating ip"
}
