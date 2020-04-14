. ../lib.sh

network-destroy private-network
network-create ./private-network.xml
domain-shutdown-all
domain-start-all
