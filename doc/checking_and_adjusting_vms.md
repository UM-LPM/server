# Checking VMs and Adjusting RAM and Disk Size

## Access to Server

Access to the server is required before proceeding.


## Managing VMs with virsh

Connect to the VM manager on the server:

```bash
virsh -c "qemu:///system"
```

### List All VMs

```bash
list
```

Displays the name and status of all virtual machines.



## Increasing RAM

RAM can be adjusted while the VM is running, but requires a restart to take effect.

### 1. Edit the VM XML config

```bash
edit vmname
```

### 2. Update the memory values

Locate and update both memory fields. You can use `KiB` or `GiB` as the unit:

```xml
<memory unit='GiB'>2</memory>
<currentMemory unit='GiB'>2</currentMemory>
```

- Both `<memory>` and `<currentMemory>` must be set to the same value.

### 3. Restart the VM

```bash
reboot vmname
```


## Increasing Disk Size

Disk size changes require the VM to be **shut down** first.

### 1. Shut down the VM

```bash
shutdown vmname
```

### 2. Resize the disk image

Increase the disk by the desired amount (e.g., +10 GB):

```bash
qemu-img resize vmdisk.img +10G
```

### 3. Start the VM again

```bash
start vmname
```


## Quick Reference

| Task | Command |
|------|---------|
| List all VMs | `list` |
| Edit VM config | `edit vmname` |
| Reboot VM | `reboot vmname` |
| Shutdown VM | `shutdown vmname` |
| Resize disk | `qemu-img resize vmdisk.img +10G` |
| Start VM | `start vmname` |