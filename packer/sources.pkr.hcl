locals {
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

  # common block
  output_directory = "builds/packer-${var.os_name}-${var.os_version}-${var.os_arch}"
  shutdown_command = var.os_name == "freebsd" ? "shutdown -p now" : "/sbin/halt -h -p"
  vm_name = var.vm_name == null ? (
    var.os_arch == "x86_64" ? "${var.os_name}-${var.os_version}-amd64" : "${var.os_name}-${var.os_version}-${var.os_arch}"
  ) : var.vm_name
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
