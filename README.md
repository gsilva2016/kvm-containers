# KVM-Containers for Intel

AI/ML/DL/LMM KVM/Containers for Intel architecture.

## Intel® Core™ Ultra processor (Series 1) KVM Ubuntu

```
sudo vim /etc/default/grub
```

Find and edit the GRUB_CMDLINE_LINUX as below:

GRUB_CMDLINE_LINUX="i915.max_vfs=4 intel_iommu=on iommu=pt"

```
sudo update-grub
```

reboot

```
./build-kvm.sh
```

Verify SR-IOV: 

```
sudo dmesg | dmesg | grep -E 'Passthrough|SR-IOV'
```

[    0.327039] pci 0000:00:05.0: DMAR: Passthrough IOMMU for integrated Intel IPU
[    0.524293] iommu: Default domain type: Passthrough (set via kernel command line)


Install Guest OS Ubuntu


Ensure to copy your Ubuntu ISO to /var/lib/libvirt/images 

# VM configuration: 8 core/8 Gb RAM/80 Gb disk.
```
virt-install \
--boot uefi \
--name ubuntu \
--vcpus 8 \
--cpu host-passthrough \
--ram 8192 \
--memballoon none \
--clock offset='localtime' \
--network network=default \
--graphics vnc,listen=0.0.0.0,port=5901 \
--video=qxl \
--disk pool=default,size=80,format=qcow2,bus=virtio \
--cdrom=/var/lib/libvirt/images/ubuntu22.04.iso \
--boot cdrom,hd \
--input tablet
```


Open up another terminal and type vncviewer 127.0.0.1:5901. Complete the Ubuntu OS installation using the installer.


Type virt-manager to manage/start/stop/interact with the VM.

