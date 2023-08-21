resource "local_file" "ansible_inventory" {
  content  = "[hosts]\n${vsphere_virtual_machine.vm.default_ip_address} ansible_user=root"
  filename = "${path.module}/../../ansible_inventory"
}
