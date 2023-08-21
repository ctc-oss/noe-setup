build {
  sources = [
    "source.qemu.vm",
    "source.vsphere-iso.vm"
  ]

  provisioner "ansible" {
    use_proxy     = false
    playbook_file = abspath("${path.root}/../provisioning/packer.yml")
    roles_path    = abspath("${path.root}/../provisioning")
    user          = "${var.vm_root_user}"
    extra_arguments = [
      "-e", "ansible_ssh_pass=${var.vm_root_password}"
    ]
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]
  }
}
