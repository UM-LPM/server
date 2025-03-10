#!/usr/bin/env bash

. ./env.sh

deploy() {
    local host=$1
    local config=$2
    nix run -- 'nixpkgs#nixos-rebuild' switch -v --target-host "$host" --build-host "$host" --flake ".#$host"
}

machine=${1:?Machine not specified}

NIXOS_SWITCH_USE_DIRTY_ENV=true deploy "$machine" "./$machine.l/configuration.nix"
