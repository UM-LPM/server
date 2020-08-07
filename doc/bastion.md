# Bastion server

## Network

Two NICs, one bridged directly to the network using macvtap, second is inside the private NAT network.

It's important that the bridge is used for internet connection (default route), otherwise the VM is not visible to the network.

You cannot ping the bastion server from the hypervisor, you always get ```Host unreachable```, ping something else to check if the connection is working.

## Connecting

### ProxyCommand

```ssh -o ProxyCommand='ssh -i <key-path> -W %h:%p bastion.lpm.feri.um.si' -i <key-path> <target>```

### ProxyJump

```
eval $(ssh-agent)
ssh-add <key-path>
ssh -J bastion.lpm.feri.um.si <target>
```

### SSH configuration
```
~/.ssh/config
```
```
Host bastion
    User <user>
    HostName bastion.lpm.feri.um.si
    IdentityFile <path>
  
Host spum-platform
    User <user>
    HostName spum-platform
    ProxyJump bastion
    IdentityFile <path>
  
Host gateway
    User <user>
    HostName gateway
    ProxyJump bastion
    IdentityFile <path>
```
