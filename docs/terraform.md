# Terraform VMs

The `terraform` source code, takes a template, builds a VM from it and then runs ansible to configure it futher.

## Prereqs

- Ansible
- Terraform

## Spin up VMs

### QEMU Rocky8 x86_64

#### Create

```bash
cd terraform/qemu
terraform apply \
    --auto-approve=true \
    --var-file="../os_tfvars/rocky/rocky-8-x86.tfvars"
cd ../../
```

OR

```bash
./tf.sh -a=apply # default is qemu rocky 8 x86_64
```

### QEMU Rocky8 aarch64

#### Create

```bash
cd terraform/qemu
terraform apply \
    --auto-approve=true \
    --var-file="../os_tfvars/rocky/rocky-8-aarch64.tfvars"
cd ../../
```

OR

```bash
./tf.sh -a=apply --os-arch="aarch64"
```

## Destroy VMs

For destroying its basically all the same other than the folder you are going to run the destroy in. Since we have different providers/vendors you need to change directory into the providers/vendors folder to be able to destroy it.

### QEMU

```bash
cd terraform/qemu
terraform destroy --auto-approve=true
cd ../../
```

OR

```bash
./tf.sh -a=destroy # default vendor is qemu
```
