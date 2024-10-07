# KVM-Containers for Intel

AI/ML/DL/LMM KVM/Containers for Intel architecture.

## Intel® Core™ Ultra processor (Series 1) KVM Ubuntu

```
./build-kvm.sh
```

reboot

Verify SR-IOV: 

```
sudo dmesg | grep -E 'Passthrough|SR-IOV'
```
