# Bastion server

## Network

Two NICs, one bridged directly to the network using macvtap, second is inside the private NAT network.

It's important that the bridge is used for internet connection (default route), otherwise the VM is not visible to the network.

You cannot ping the bastion server from the hypervisor, you always get Host unreachable, ping something else to check if the connection is working.

## Connecting

### ProxyCommand

```ssh -o ProxyCommand='ssh -i <key-path> -W %h:%p <bastion>' -i <key-path> <target>```

### ProxyJump

```
eval $(ssh-agent)
ssh-add <key-path>
ssh -J <bastion> <target>
```
