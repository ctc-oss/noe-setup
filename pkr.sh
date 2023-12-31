#!/usr/bin/env bash

source env.sh

function qemu-rocky8() {
    [[ ! -z $1 && $1 == "aarch" ]] \
    && export arch="aarch64" \
    || export arch="x86"

    packer build \
        --var-file="os_pkrvars/rocky/rocky-8-$arch.pkrvars.hcl" \
        --only=qemu.vm \
        --on-error=ask .
}

function vsphere-rocky8() {
    [[ ! -z $1 && $1 == "aarch" ]] \
    && export arch="aarch64" \
    || export arch="x86"

    packer build \
        --var-file="os_pkrvars/rocky/rocky-8-$arch.pkrvars.hcl" \
        --only=vsphere-iso.vm \
        --on-error=ask .
}

cd packer
$@
cd ../
