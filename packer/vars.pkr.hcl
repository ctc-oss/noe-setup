# specifc variables for oses
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

# offline variables
variable "is_offline" {
  type        = bool
  default     = false
  description = "Deployment is offline"
}

# specifc qemu variables
variable "qemu_kvm" {
  type        = bool
  default     = false
  description = "Use qemu-kvm instead of qemu-system (rhel)"
}

# specifc vsphere variables
variable "convert_to_template" {
  type        = bool
  default     = true
  description = "Convert VM to VM template"
}
variable "dns_server_list" {
  type        = list
  default     = []
  description = "List of DNS servers to use"
}
variable "insecure_connection" {
  type        = bool
  default     = true
  description = "Insecure vSphere connection"
}
variable "vsphere_cluster" {
  type        = string
  default     = ""
  description = "vSphere cluster to use"
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
variable "vsphere_server" {
  type        = string
  default     = ""
  description = "vSphere server to connect to"
}
variable "vsphere_user" {
  type        = string
  default     = ""
  description = "vSphere user to authenticate as"
}

# specific macos variables
variable "use_macos" {
  type    = bool
  default = false
}

# common variables
variable "boot_command" {
  type    = list(string)
  default = null
}
variable "boot_wait" {
  type    = string
  default = "10s"
}
variable "communicator" {
  type    = string
  default = "ssh"
}
variable "cpus" {
  type    = number
  default = 2
}
variable "disk_size" {
  type    = number
  default = 65536
}
variable "headless" {
  type    = bool
  default = true
}
variable "ipv4_gateway" {
  type    = string
  default = null
}
variable "iso_checksum" {
  type        = string
  default     = null
  description = "ISO download checksum"
}
variable "iso_url" {
  type        = string
  default     = null
  description = "ISO download url"
}
variable "ks_template" {
  type    = string
  default = null
}
variable "memory" {
  type    = number
  default = 4096
}
variable "ssh_port" {
  type    = number
  default = 22
}
variable "ssh_timeout" {
  type    = string
  default = "60m"
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
