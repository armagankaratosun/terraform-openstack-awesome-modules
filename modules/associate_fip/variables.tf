variable openstack_vm_floatingip { 
   type = list
   description = "fixed public ip address for the vm, can be a list of ips"
}
variable "vm_instance_id" {
    type = list
    description = "instance ids of the vms that will be assigned with a floating ip"
}