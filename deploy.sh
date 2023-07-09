#!/usr/bin/env bash

. ./env.sh

token=${2:?Access token not specified}

deploy() {
    local host=$1
    local config=$2
    nix --access-tokens "github.com=$token" run -- 'nixpkgs#nixos-rebuild' switch --target-host "$host" --flake ".#$host"  
}

machine=${1:?Machine not specified}

deploy "$machine" "./$machine/configuration.nix"

#deploy gateway './gateway/configure.nix'
#deploy spum-platform './spum-platform/configure.nix'
#deploy spum-mqtt './spum-mqtt/configure.nix'
##deploy spum-docker-registry './spum-docker-registry/configure.nix'
#deploy builder './builder/configure.nix'
#deploy grades './grades/configure.nix'
#deploy ps './ps/configure.nix'
#deploy esp './esp/configure.nix'
#deploy usatour './usatour/configure.nix'
#deploy calendar './calendar/configure.nix'
#deploy prometheus './prometheus/configure.nix'
#deploy bioma './bioma/configure.nix'
##deploy mihaelhpc './mihaelhpc/configure.nix' 'https://github.com/NixOS/nixpkgs/archive/7e9b0dff974c89e070da1ad85713ff3c20b0ca97.tar.gz'
#deploy gb './gb/configure.nix'
#deploy ears './ears/configure.nix'
#deploy collab './collab/configure.nix'
