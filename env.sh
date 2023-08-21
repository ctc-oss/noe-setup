#!/usr/bin/env bash

[[ -f .env ]] && source .env || true

# packer variables
export PKR_VAR_os_name=${OS_NAME:-""}
export PKR_VAR_os_version=${OS_VERSION:-""}
export PKR_VAR_os_arch=${OS_ARCH:-""}

export PKR_VAR_is_offline=${IS_OFFLINE:-""}

export PKR_VAR_qemu_kvm=${QEMU_KVM:-""}

export PKR_VAR_convert_to_template=${CONVERT_TO_TEMPLATE:-""}
export PKR_VAR_dns_server_list=${DNS_SERVER_LIST:-""}
export PKR_VAR_insecure_connection=${INSECURE_CONNECTION:-""}
export PKR_VAR_vsphere_cluster=${VSPHERE_CLUSTER:-""}
export PKR_VAR_vsphere_datacenter=${VSPHERE_DATACENTER:-""}
export PKR_VAR_vsphere_datastore=${VSPHERE_DATASTORE:-""}
export PKR_VAR_vsphere_host=${VSPHERE_HOST:-""}
export PKR_VAR_vsphere_network=${VSPHERE_NETWORK:-""}
export PKR_VAR_vsphere_resource_pool=${VSPHERE_RESOURCE_POOL:-""}
export PKR_VAR_vsphere_password=${VSPHERE_PASSWORD:-""}
export PKR_VAR_vsphere_server=${VSPHERE_SERVER:-""}
export PKR_VAR_vsphere_user=${VSPHERE_USER:-""}

export PKR_VAR_use_macos=${USE_MACOS:-""}

export PKR_VAR_boot_command=${BOOT_COMMAND:-""}
export PKR_VAR_boot_wait=${BOOT_WAIT:-""}
export PKR_VAR_communicator=${COMMUNICATOR:-""}
export PKR_VAR_cpus=${CPUS:-""}
export PKR_VAR_disk_size=${DISK_SIZE:-""}
export PKR_VAR_headless=${HEADLESS:-""}
export PKR_VAR_ipv4_gateway=${IPV4_GATEWAY:-""}
export PKR_VAR_iso_checksum=${ISO_CHECKSUM:-""}
export PKR_VAR_iso_url=${ISO_URL:-""}
export PKR_VAR_ks_template=${KS_TEMPLATE:-""}
export PKR_VAR_memory=${MEMORY:-""}
export PKR_VAR_ssh_port=${SSH_PORT:-""}
export PKR_VAR_ssh_timeout=${SSH_TIMEOUT:-""}
export PKR_VAR_vm_name=${VM_NAME:-""}
export PKR_VAR_vm_root_password=${VM_ROOT_PASSWORD:-"rootPass123!"}
export PKR_VAR_vm_root_user=${VM_ROOT_USER:-"root"}
export PKR_VAR_vm_static_ip=${VM_STATIC_IP:-""}

# terraform variables
export TF_VAR_dns_server_list=${DNS_SERVER_LIST:-""}
export TF_VAR_vsphere_datacenter=${VSPHERE_DATACENTER:-""}
export TF_VAR_vsphere_datastore=${VSPHERE_DATASTORE:-""}
export TF_VAR_vsphere_host=${VSPHERE_HOST:-""}
export TF_VAR_vsphere_network=${VSPHERE_NETWORK:-""}
export TF_VAR_vsphere_password=${VSPHERE_PASSWORD:-""}
export TF_VAR_vsphere_resource_pool=${VSPHERE_RESOURCE_POOL:-""}
export TF_VAR_vsphere_server=${VSPHERE_SERVER:-""}
export TF_VAR_vsphere_template=${VSPHERE_TEMPLATE:-""}
export TF_VAR_vsphere_user=${VSPHERE_USER:-""}

export TF_VAR_cpus=${CPUS:-""}
export TF_VAR_disk_size=${DISK_SIZE:-""}
export TF_VAR_ipv4_gateway=${IPV4_GATEWAY:-""}
export TF_VAR_memory=${MEMORY:-""}
export TF_VAR_vm_name=${VM_NAME:-""}
export TF_VAR_vm_root_password=${VM_ROOT_PASSWORD:-"rootPass123!"}
export TF_VAR_vm_root_user=${VM_ROOT_USER:-"root"}
export TF_VAR_vm_static_ip=${VM_STATIC_IP:-""}
