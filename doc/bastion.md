# Bastion server

## Network

Two NICs, one bridged directly to the network using macvtap, second is inside the private NAT network.

It's important that the bridge is used for internet connection (default route), otherwise the VM is not visible to the network.

You cannot ping the bastion server from the hypervisor, you always get Host unreachable, ping something else to check if the connection is working.

## Connecting

### ProxyCommand

ssh -o ProxyCommand='ssh -i ~/.ssh/lpm -W %h:%p <bastion>' -i ~/.ssh/lpm <target>

### ProxyJump

eval $(ssh-agent)
ssh-add <key-path>
ssh -J user@10.17.3.14 user@10.17.3.140
