#!/usr/bin/env bash

. ./env.sh

deploy() {
    local host=$1
    local config=$2
    nix run  --no-eval-cache -- 'nixpkgs#nixos-rebuild' switch --target-host "$host" --flake ".#$host" 
}

machine=${1:?Machine not specified}

deploy "$machine" "./$machine.l/configuration.nix"
