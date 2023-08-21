locals {
  # common block
  bootproto = (
    var.vm_static_ip == null || var.vm_static_ip == "" || var.ipv4_gateway == null || var.ipv4_gateway == "" ?
    "dhcp" :
    "static --ip=${var.vm_static_ip} --netmask 255.255.255.0 --gateway=${var.ipv4_gateway}"
  )
  output_directory = "builds/packer-${var.os_name}-${var.os_version}-${var.os_arch}"
  shutdown_command = var.os_name == "freebsd" ? "shutdown -p now" : "/sbin/halt -h -p"
  vm_name = var.vm_name == null ? (
    var.os_arch == "x86_64" ? "${var.os_name}-${var.os_version}-amd64" : "${var.os_name}-${var.os_version}-${var.os_arch}"
  ) : var.vm_name

  # qemu block
  qemu_binary           = var.qemu_kvm ? "/usr/libexec/qemu-kvm" : "qemu-system-${var.os_arch}"
  qemu_disk_compression = true
  qemu_display          = var.headless ? "none" : (var.use_macos ? "cocoa" : "default")
  qemu_format           = "qcow2"
  qemu_machine_type     = var.os_arch == "aarch64" ? "virt" : "q35"
  qemuargs = var.os_arch == "aarch64" ? [
    ["-boot", "strict=off"],
    ["-m", var.memory],
  ] : [["-m", var.memory]]

  # vsphere block
  vsphere_iso_url = var.is_offline ? "[${var.vsphere_datastore}] ${var.iso_url}" : var.iso_url
}

source "qemu" "vm" {
  # QEMU specific items
  disk_compression = true
  display          = local.qemu_display
  format           = local.qemu_format
  machine_type     = local.qemu_machine_type
  qemu_binary      = local.qemu_binary
  qemuargs         = local.qemuargs

  # common options
  boot_command = var.boot_command
  boot_wait    = var.boot_wait
  communicator = var.communicator
  cpus         = var.cpus
  disk_size    = var.disk_size
  headless     = var.headless
  http_content = {
    "/ks.cfg" = templatefile(var.ks_template, {
      vm_root_password = "${var.vm_root_password}"
    })
  }
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  memory           = var.memory
  output_directory = "${local.output_directory}-qemu"
  shutdown_command = local.shutdown_command
  ssh_password     = var.vm_root_password
  ssh_port         = var.ssh_port
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.vm_root_user
  vm_name          = local.vm_name
}

source "vsphere-iso" "vm" {
  # vsphere specific items
  ## Nice to have vsphere settings
  CPUs = var.cpus
  RAM  = var.memory
  configuration_parameter = {
    "svga.autodetect"                      = "TRUE",
    "isolation.tools.copy.disable"         = "FALSE",
    "isolation.tools.paste.disable"        = "FALSE",
    "isolation.tools.setGUIOptions.enable" = "TRUE"
  }
  cluster             = var.vsphere_cluster
  datacenter          = var.vsphere_datacenter
  datastore           = var.vsphere_datastore
  host                = var.vsphere_host
  insecure_connection = var.insecure_connection
  password            = var.vsphere_password
  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }
  resource_pool = var.vsphere_resource_pool
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = true
  }
  username       = var.vsphere_user
  vcenter_server = var.vsphere_server

  # common options
  boot_command = var.boot_command
  boot_wait    = var.boot_wait
  communicator = var.communicator
  http_content = {
    "/ks.cfg" = templatefile(var.ks_template, {
      bootproto        = local.bootproto
      vm_root_password = "${var.vm_root_password}"
    })
  }
  iso_url          = local.vsphere_iso_url
  iso_checksum     = var.iso_checksum
  output_directory = "${local.output_directory}-vsphere"
  shutdown_command = local.shutdown_command
  ssh_password     = var.vm_root_password
  ssh_port         = var.ssh_port
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.vm_root_user
  vm_name          = local.vm_name
}