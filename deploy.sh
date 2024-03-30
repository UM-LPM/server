#!/usr/bin/env bash

. ./env.sh

deploy() {
    local host=$1
    local config=$2
    nix run -- 'nixpkgs#nixos-rebuild' switch -v --target-host "$host" --flake ".#$host" 
}

machine=${1:?Machine not specified}

deploy "$machine" "./$machine.l/configuration.nix"
