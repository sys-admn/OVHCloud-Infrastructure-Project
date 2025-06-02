output "bastion_public_ip" {
  value     = module.instances.bastion_ip
  sensitive = false
}
output "kubeconfig_file" {
  value     = module.kubernetes.kube_config
  sensitive = true
}
