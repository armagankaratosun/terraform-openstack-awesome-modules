### VM Variables ###
variable openstack_vmname {
   type = list
   description = "openstack vm name, can be a list of vms"
}
variable openstack_flavor_id { 
   type = string
   description = "Openstack vm flavor, this will be the vm resources for your nodes."
}
variable openstack_image_id {  
   type = string
   description = "Openstack vm image , this will be the vm os image for your nodes."
}
variable openstack_net_name { 
   type = string
   description = "private network of the vm"
}
variable openstack_sec_groups { 
   type = list
   default = ["default"]
   description = " Openstack security groups, this security group will be used by the nodes. you can define a list as well."
}
variable openstack_boot_volume_size { 
   type = number
   default = 25
   description = "the root disk will be 25G by default. it is (mostly) ok."
}
variable "cloud_init_data" {
   type = string
   description = "user-input for cloud init"
}
variable openstack_keypair_name {
   type = string
   description = "the ssh key pair that will be injected to the VM"
}
variable "fixed_ip_v4" {
   description = "List of fixed IPv4 addresses to be used on the network."
   type        = list(string)
   default     = [""]
}
