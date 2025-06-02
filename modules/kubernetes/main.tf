resource "ovh_cloud_project_kube" "my_cluster" {
  service_name       = var.service_id
  name               = "ovh_kms"
  region             = var.os_region
  nodes_subnet_id    = var.private_subnet_id
  private_network_id = var.private_network_id

  depends_on = [var.private_network_id, var.private_subnet_id]

  timeouts {
    create = "20m"
    update = "10m"
    delete = "10m"
  }
}

resource "ovh_cloud_project_kube_nodepool" "node_pool" {
  service_name  = var.service_id
  kube_id       = ovh_cloud_project_kube.my_cluster.id
  name          = "kms-pool"
  flavor_name   = "b2-7"
  desired_nodes = 1
  max_nodes     = 3
  min_nodes     = 1

  timeouts {
    create = "20m"
    update = "10m"
    delete = "10m"
  }
}
