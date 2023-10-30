output "instance_id" {
  description = "IDs of the created VM instances"
  value       = openstack_compute_instance_v2.vm.*.id
}
