#!/bin/bash

APT_INSTALL_FAIL=0
sudo DEBIAN_FRONTEND=noninteractive apt-get install git vim socat autoconf xtightvncviewer tightvncserver x11vnc uuid-runtime uuid qemu-kvm ovmf libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager -y || APT_INSTALL_FAIL=1

if [ "$APT_INSTALL_FAIL" = "1" ]
then
	echo "Install of KVM pre-reqs failed."
	exit 1
fi

sleep 1

sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER

sleep 1

for i in $(seq 0 $(($(nproc)-1))); do \
	echo performance | sudo tee \
	/sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor; \
done

echo "kvm-ok: "
kvm-ok
