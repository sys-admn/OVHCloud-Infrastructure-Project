variable "service_id" {}
variable "os_private_network_vlan_id" {}
variable "os_region" {}
variable "network_name" {}
variable "network" { default = "192.168.10.0/24" }
variable "dhcp" { default = true }
variable "dhcp_start" { default = "192.168.10.10" }
variable "dhcp_end" { default = "192.168.10.100" }

