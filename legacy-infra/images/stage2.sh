. ../lib.sh

volume-create-backing images bastion.qcow2 8G bastion-base-v1.qcow2
volume-create-backing images gateway.qcow2 8G minimal-base-v1.qcow2
volume-create-backing images builder.qcow2 8G minimal-base-v1.qcow2
