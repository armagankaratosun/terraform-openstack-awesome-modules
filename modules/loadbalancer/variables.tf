variable openstack_net_name { 
   type = string
   description = "private network of the vm"
}
variable openstack_lb_name { # public ip address for the vm (optional)
   type = string
   description = "name of the loadbalancer"
}
variable openstack_listener_name { 
   type = list
   description = " loadbalancer listener name. you can define a list as well."
}

variable openstack_lb_floatingip { # public ip address for the vm (optional)
   type = string
   description = "floating ip address of the loadbalancer"
}