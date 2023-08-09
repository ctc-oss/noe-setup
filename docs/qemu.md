# QEMU Support

The Packer and Terraform support QEMU. To enable this libvirt and virt-mananer are needed. Below will show to set them up

## Linux - Yum package manager

- Using Linux OSes with the `yum` package manager you will only be able to build x86 images.

```bash
sudo dnf install @virt virt-top libguestfs-tools virt-install
sudo systemctl enable --now libvirtd
sudo dnf install virt-manager

# Add this line to your .bashrc or .zshrc
export PKR_VAR_qemu_kvm="true" # this ensures the packer uses the qemu-kvm exectuable
```

## Linux - Apt package manager

- Using Linux OSes with the `apt` package manager you will be able to make both x86 and aarch64 images. However, the version of the binaries provided through `apt` for QEMU are too outdated and don't work well. So due to this we need to manually build and install a new version of QEMU. To do this follow section QEMU 0.8.3.

## QEMU 0.8.3

QEMU 0.8.3 is a known good version to work with the Packer code so it will be the version instructed to download. Currently we focus on installing inside of a machine with the `apt` package manager, but something similar may be able to be done with `yum`. However, `yum`'s default version allows for x86 to be built perfectly fine. So, the only reason for doing this on a `yum` machine would be so that the `aarch` versions can be built.

#### Prereqs

```bash
sudo wget -qO /usr/local/bin/ninja.gz https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip
sudo gunzip /usr/local/bin/ninja.gz
sudo chmod a+x /usr/local/bin/ninja

sudo apt install \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    pkg-config \
    virt-manager \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    flex \
    bison \
    slirp \
    libslirp0 \
    libslirp-dev \
    sshpass \
    xsltproc

# To use terraform this need set
sudo sed -ie 's|#security_driver = "selinux"|security_driver = "none"|' /etc/libvirt/qemu.conf
sudo systemctl restart libvirtd
```

#### Download & Install QEMU

```bash
wget https://download.qemu.org/qemu-8.0.3.tar.xz
tar -xvJf qemu-8.0.3.tar.xz
cd qemu-8.0.3
./configure
sudo make install

sudo vim /etc/apparmor.d/abstractions/libvirt-qemu
# Add below lines after line with "Site-specific additions and overrides",  without the # infront
# /usr/local/bin/* rmix,
# /usr/local/share/qemu/* r,

sudo vim /etc/apparmor.d/usr.sbin.libvirtd
# Add below lines after line with "Site-specific additions and overrides", without the # infront
# /usr/local/bin/* PUx,

sudo systemctl restart apparmor.service
```
