#! /usr/bin/env nix-shell
#! nix-shell -i bash -p "(nixos {}).nixos-rebuild"

#nixos-rebuild switch --target-host ssh://root@10.17.3.134 -I nixos-config='gateway/configure.nix'
#nixos-rebuild switch --target-host ssh://root@lpm-bastion.feri.um.si -I nixos-config='bastion/configure.nix'

NIX_SSHOPTS='-F ./ssh_config' nixos-rebuild switch --target-host ssh://spum_platform -I nixos-config='./spum-platform/configure.nix'