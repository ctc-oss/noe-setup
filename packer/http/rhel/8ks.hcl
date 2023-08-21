cdrom
lang en_US.UTF-8
keyboard us
text
network --bootproto=${var.bootproto} --noipv6 --onboot=on --device=eth0
rootpw --plaintext ${vm_root_password}
firewall --enable --ssh
selinux --disabled
timezone --utc America/New_York
bootloader --timeout=1 --location=mbr --append="net.ifnames=0 biosdevname=0"
skipx
zerombr
clearpart --all --initlabel
authselect --enableshadow --passalgo=sha512
autopart --nohome --nolvm --noboot
firstboot --disabled
reboot --eject

%packages --ignoremissing --excludedocs --instLangs=en_US.utf8
openssh-clients
sudo
selinux-policy-devel
wget
nfs-utils
net-tools
tar
bzip2
deltarpm
rsync
dnf-utils
redhat-lsb-core
elfutils-libelf-devel
network-scripts
-fprintd-pam
-intltool
-iwl*-firmware
-microcode_ctl
%end

%post
sed -ie 's|.*PermitRootLogin\sno|PermitRootLogin yes|' /etc/ssh/sshd_config
%end
