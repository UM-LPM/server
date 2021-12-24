. ../lib.sh

virsh net-update private-network add ip-dhcp-host "<host mac='02:af:e7:1b:e5:de' name='gb' ip='10.17.3.190' />" --live --config
virsh net-update private-network add ip-dhcp-host "<host mac='02:33:74:0c:86:ee' name='ears' ip='10.17.3.200' />" --live --config


