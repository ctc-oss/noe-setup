terraform {
  version = "1.5.5"
}

providers {
  vsphere = {
    source   = "hashicorp/vsphere"
    versions = [">= 2.1.0"]
  }

  local = {
    source   = "hashicorp/local"
    versions = [">= 2.2.2"]
  }
  
  libvirt = {
    source   = "dmacvicar/libvirt"
    versions = ["0.6.14"]
  }
}
