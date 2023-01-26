. ../lib.sh

pool-create images /var/lib/virt/images

volume-create images minimal-base-v1.qcow2 8G
volume-create images bastion-base-v1.qcow2 8G

volume-upload images minimal-base-v1.qcow2 ./minimal.qcow2
volume-upload images bastion-base-v1.qcow2 ./bastion.qcow2
