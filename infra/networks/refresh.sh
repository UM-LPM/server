. ../lib.sh

network-destroy private-network
network-create ./private-network.xml

machines=$(virsh list --name)
for name in $machines
do
    domain-shutdown "$name"
done
for name in $machines
do
    domain-start "$name"
done
