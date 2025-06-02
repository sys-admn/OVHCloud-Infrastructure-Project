resource "openstack_compute_keypair_v2" "elab_key" {
  public_key = var.ssh_public_key
  name       = "bastion"
  region     = var.os_region
}

resource "openstack_compute_instance_v2" "bastion" {
  name        = "bastion"
  image_name  = var.image_name
  flavor_name = var.flavor_name
  key_pair    = openstack_compute_keypair_v2.elab_key.name
  region      = var.os_region

  network {
    uuid = var.private_network_id
  }

  security_groups = ["default"]
}

resource "openstack_networking_floatingip_v2" "bastion_fip" {
  pool = "Ext-Net"
}

resource "openstack_compute_floatingip_associate_v2" "bastion_fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.bastion_fip.address
  instance_id = openstack_compute_instance_v2.bastion.id
}
