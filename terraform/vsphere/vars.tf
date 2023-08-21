variable "dns_server_list" {
  type        = list(any)
  default     = []
  description = "List of DNS servers to use"
}
variable "vsphere_datacenter" {
  type        = string
  default     = ""
  description = "vSphere datacenter to use"
}
variable "vsphere_datastore" {
  type        = string
  default     = "datastore1"
  description = "vSphere datacenter to use"
}
variable "vsphere_host" {
  type        = string
  default     = ""
  description = "vSphere host to use"
}
variable "vsphere_network" {
  type        = string
  default     = "VM Network"
  description = "vSphere network to use"
}
variable "vsphere_password" {
  type        = string
  default     = ""
  description = "vSphere user password to authenticate with"
}
variable "vsphere_resource_pool" {
  type        = string
  default     = ""
  description = "vSphere resource pool to use"
}
variable "vsphere_server" {
  type        = string
  default     = ""
  description = "vSphere server to connect to"
}
variable "vsphere_template" {
  type        = string
  default     = ""
  description = "vSphere template to use"
}
variable "vsphere_user" {
  type        = string
  default     = ""
  description = "vSphere user to authenticate as"
}

# common variables
variable "cpus" {
  type    = number
  default = 2
}
variable "disk_size" {
  type    = number
  default = 65536
}
variable "ipv4_gateway" {
  type    = string
  default = null
}
variable "memory" {
  type    = number
  default = 4096
}
variable "vm_name" {
  type    = string
  default = null
}
variable "vm_root_password" {
  type    = string
  default = "rootPass123!"
}
variable "vm_root_user" {
  type    = string
  default = "root"
}
variable "vm_static_ip" {
  type    = string
  default = null
}

# user to add
variable "user_to_add_name" {
  type        = string
  default     = "developer"
  description = "Username for the user to add"
}
variable "user_to_add_password" {
  type        = string
  default     = "devPass123!"
  description = "Password for the user to add"
}
