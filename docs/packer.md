# Packer Builds

The packer source code is based off [chef/bento packer](https://github.com/chef/bento). Currently, we are only supporting rocky8 but have the structure setup in a way that we could add more OSes, eg rocky9, in the future. 

## Prereqs

- Ansible
- Packer

## Running Builds

### QEMU Rocky8 x86_64

```bash
cd packer
packer build \
    --var-file="os_pkrvars/rocky/rocky-8-x86.pkrvars.hcl" \
    --only=qemu.vm \
    --on-error=ask .
cd ../
```

OR

```bash
./pkr.sh qemu-rocky8
```

### QEMU Rocky8 aarch64

```bash
cd packer
packer build \
    --var-file="os_pkrvars/rocky/rocky-8-aarch64.pkrvars.hcl" \
    --only=qemu.vm \
    --on-error=ask .
cd ../
```

OR

```bash
./pkr.sh qemu-rocky8 aarch
```
