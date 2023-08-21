resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  host_system_id   = data.vsphere_host.host.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = data.vsphere_virtual_machine.template.num_cpus
  memory           = data.vsphere_virtual_machine.template.memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  firmware         = data.vsphere_virtual_machine.template.firmware

  # Enable I/O MMU
  vvtd_enabled = true
  # Enable hardware virtualization
  nested_hv_enabled = true
  # Enable performance counters
  cpu_performance_counters_enabled = true

  wait_for_guest_ip_timeout  = 5
  wait_for_guest_net_timeout = 5

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = replace(var.vm_name, "_", "-")
        domain    = "noe"
      }

      network_interface {
        ipv4_address = var.vm_static_ip
        ipv4_netmask = 24
      }

      ipv4_gateway    = var.ipv4_gateway
      dns_server_list = var.dns_server_list
    }
  }

  # wait for ssh
  provisioner "remote-exec" {
    inline = [
      "echo 'Connected'"
    ]

    connection {
      type     = "ssh"
      user     = var.vm_root_user
      host     = var.vm_static_ip
      password = var.vm_root_password
      timeout  = "10m"
    }
  }

  # create new user
  provisioner "local-exec" {
    command = <<EOF
      ANSIBLE_HOST_KEY_CHECKING=False
      ansible-playbook -vv \
        -u ${var.vm_root_user} \
        -i '${var.vm_static_ip},' \
        -e 'ansible_ssh_pass=${var.vm_root_password}' \
        -e 'user_to_add_name=${var.user_to_add_name}' \
        -e 'user_to_add_password=${var.user_to_add_password}' \
        ${path.module}/../../provisioning/add_user.yml
    EOF
  }

  # run provisioning as new user
  provisioner "local-exec" {
    command = <<EOF
      ANSIBLE_HOST_KEY_CHECKING=False
      ansible-playbook -vv \
        -u ${var.user_to_add_name} \
        -i '${var.vm_static_ip},' \
        -e 'ansible_ssh_pass=${var.user_to_add_password}' \
        ${path.module}/../../provisioning/terraform.yml
    EOF
  }
}