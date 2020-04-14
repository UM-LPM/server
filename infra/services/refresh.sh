. ../lib.sh

domain-destroy bastion
domain-destroy gateway
domain-destroy builder

domain-create ./bastion.xml
domain-create ./gateway.xml
domain-create ./builder.xml
