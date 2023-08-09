locals {
  img_path = var.img_path == null ? (
    "${path.module}/../../packer/builds/packer-${var.os_name}-${var.os_version}-${var.os_arch}-qemu"
  ) : var.img_path
  img_name = var.img_name == null ? (
    var.os_arch == "x86_64" ? "${var.os_name}-${var.os_version}-amd64" : "${var.os_name}-${var.os_version}-${var.os_arch}"
  ) : var.img_name
  libvirt_disk_path = var.libvirt_disk_path == null ? "/opt/kvm/pool1" : var.libvirt_disk_path
  libvirt_uri       = var.libvirt_uri == null ? "qemu:///system" : var.libvirt_uri
}

resource "libvirt_pool" "noepool" {
  name = "noepool"
  type = "dir"
  path = local.libvirt_disk_path
}

resource "libvirt_volume" "noe-qcow2" {
  name   = "noe-qcow2"
  pool   = libvirt_pool.noepool.name
  source = "${local.img_path}/${local.img_name}"
  format = "qcow2"
}

resource "libvirt_network" "noenet" {
  name      = "noenet"
  mode      = "nat"
  addresses = [var.vm_network_cidr]
}

resource "libvirt_domain" "noe" {
  name       = var.vm_hostname
  memory     = var.memory
  vcpu       = var.cpus
  qemu_agent = true
  autostart  = true

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.noe-qcow2.id
  }

  network_interface {
    network_id = libvirt_network.noenet.id
    hostname   = var.vm_hostname
    addresses  = [var.vm_static_ip]
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }

  boot_device {
    dev = ["cdrom", "hd"]
  }

  xml {
    xslt = <<-EOT
      <?xml version="1.0" ?>
      <xsl:stylesheet version="1.0"
                      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:output omit-xml-declaration="yes" indent="yes"/>

        <!-- Copy everything from the generated XML -->
        <xsl:template match="node()|@*">
          <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
          </xsl:copy>
        </xsl:template>

        <xsl:template match="/domain/@type">
          <xsl:attribute name="type">
              <xsl:value-of select="'qemu'"/>
          </xsl:attribute>
        </xsl:template>

      </xsl:stylesheet>
    EOT
  }

  # wait for ssh
  provisioner "remote-exec" {
    inline = [
      "echo 'Connected'"
    ]

    connection {
      type     = "ssh"
      user     = var.ssh_username
      host     = var.vm_static_ip
      password = var.ssh_password
      timeout  = "10m"
    }
  }

  # create new user
  provisioner "local-exec" {
    command = <<EOF
      ANSIBLE_HOST_KEY_CHECKING=False
      ansible-playbook -vv \
        -u ${var.ssh_username} \
        -i '${var.vm_static_ip},' \
        -e 'ansible_ssh_pass=${var.ssh_password}' \
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
