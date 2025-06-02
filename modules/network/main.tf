resource "ovh_cloud_project_network_private" "private_network" {
  service_name = var.service_id
  name         = "${var.network_name}-private-network"
  vlan_id      = var.os_private_network_vlan_id
  regions      = tolist(split(",", var.os_region))
}

resource "ovh_cloud_project_network_private_subnet" "private_subnet" {
  service_name = var.service_id
  network_id   = ovh_cloud_project_network_private.private_network.id
  region       = var.os_region
  start        = var.dhcp_start
  end          = var.dhcp_end
  network      = var.network
  dhcp         = true
  no_gateway   = false
}

data "openstack_networking_network_v2" "public_network" {
  name   = "Ext-Net"
  region = var.os_region
}

resource "openstack_networking_router_v2" "router" {
  name                = "${var.network_name}-router"
  region              = var.os_region
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  region    = var.os_region
  router_id = openstack_networking_router_v2.router.id
  subnet_id = ovh_cloud_project_network_private_subnet.private_subnet.id
}

data "openstack_networking_network_v2" "private_network" {
  name       = ovh_cloud_project_network_private.private_network.name
  region     = var.os_region
  depends_on = [ovh_cloud_project_network_private_subnet.private_subnet]
}
