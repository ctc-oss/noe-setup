# OS variables
variable "os_name" {
  type        = string
  description = "OS Brand Name"
}
variable "os_version" {
  type        = string
  description = "OS version number"
}
variable "os_arch" {
  type = string
  validation {
    condition     = var.os_arch == "x86_64" || var.os_arch == "aarch64"
    error_message = "The OS architecture type should be either x86_64 or aarch64."
  }
  description = "OS architecture type, x86_64 or aarch64"
}

# Libvirt specific vars
variable "libvirt_disk_path" {
  type        = string
  default     = null
  description = "path for libvirt pool"
}
variable "libvirt_uri" {
  type    = string
  default = null
}
variable "img_path" {
  type        = string
  default     = null
  description = "qcow2 image file path"
}
variable "img_name" {
  type        = string
  default     = null
  description = "qcow2 image file name"
}

# vm settings
variable "cpus" {
  type    = number
  default = 2
}
variable "disk_size" {
  type    = number
  default = 65536
}
variable "memory" {
  type    = number
  default = 4096
}
variable "ssh_username" {
  type    = string
  default = "root"
}
variable "ssh_password" {
  type    = string
  default = "rootPass123!"
}
variable "vm_hostname" {
  type    = string
  default = "noe-kvm"
}

# networking
variable "vm_network_cidr" {
  type        = string
  default     = "10.0.0.0/24"
  description = "IPv4 CIDR for the libvirt network"
}
variable "vm_static_ip" {
  # this is required for the playbook
  # look at the bridge being used, usually virbr0, and pick an IP in its subnet
  type        = string
  default     = "10.0.0.200"
  description = "Static IP address desired for the VM"
}

# user to add
variable "user_to_add_name" {
  type = string
  default = "developer"
  description = "Username for the user to add"
}
variable "user_to_add_password" {
  type = string
  default = "devPass123!"
  description = "Password for the user to add"
}
