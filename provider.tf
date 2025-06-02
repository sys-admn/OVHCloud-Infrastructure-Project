terraform {
  required_version = ">= 0.14.0"
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

provider "openstack" {
  domain_name = "default"
  user_name   = var.openstack_user_name
  password    = var.openstack_password
  tenant_name = var.openstack_tenant_name
  region      = var.os_region
  auth_url    = "https://auth.cloud.ovh.net/v3/"
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}
