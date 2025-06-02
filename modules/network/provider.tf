terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
    ovh = {
      source  = "ovh/ovh"
      version = ">= 0.13.0"
    }
  }
}
