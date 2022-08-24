#! /usr/bin/env nix-shell
#! nix-shell -i bash -p "(nixos {}).nixos-rebuild"

. ./env.sh

deploy() {
    local host=$1
    local config=$2
    local pkgs=${3:-https://channels.nixos.org/nixos-21.05/nixexprs.tar.xz}
    nixos-rebuild switch --upgrade --target-host "$host" -I nixpkgs="$pkgs" -I nixos-config="$config" --show-trace
}

deploy bastion './bastion/configure.nix'
deploy gateway './gateway/configure.nix'
deploy spum-platform './spum-platform/configure.nix'
deploy spum-mqtt './spum-mqtt/configure.nix'
#deploy spum-docker-registry './spum-docker-registry/configure.nix'
deploy builder './builder/configure.nix'
deploy grades './grades/configure.nix'
deploy ps './ps/configure.nix'
deploy esp './esp/configure.nix'
deploy usatour './usatour/configure.nix'
deploy calendar './calendar/configure.nix'
deploy prometheus './prometheus/configure.nix'
deploy bioma './bioma/configure.nix'
#deploy mihaelhpc './mihaelhpc/configure.nix' 'https://github.com/NixOS/nixpkgs/archive/7e9b0dff974c89e070da1ad85713ff3c20b0ca97.tar.gz'
deploy gb './gb/configure.nix'
deploy ears './ears/configure.nix'
deploy collab './collab/configure.nix'
