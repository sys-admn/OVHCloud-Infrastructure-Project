module "network" {
  source                     = "./modules/network"
  service_id                 = var.service_id
  network_name               = var.network_name
  os_private_network_vlan_id = var.os_private_network_vlan_id
  os_region                  = var.os_region
}

module "instances" {
  source             = "./modules/instances"
  os_region          = var.os_region
  image_name         = var.image_name
  flavor_name        = var.flavor_name
  ssh_public_key     = var.ssh_public_key
  private_network_id = module.network.private_network_data
  depends_on         = [module.network]
}

module "kubernetes" {
  source             = "./modules/kubernetes"
  service_id         = var.service_id
  os_region          = var.os_region
  private_subnet_id  = module.network.private_subnet_id
  private_network_id = module.network.private_network_data
  depends_on         = [module.network]
}
