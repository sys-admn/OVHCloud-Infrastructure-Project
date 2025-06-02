output "private_subnet_id" {
  value = ovh_cloud_project_network_private_subnet.private_subnet.id
}

output "private_network_data" {
  value = data.openstack_networking_network_v2.private_network.id
}

