build() {
    nix build --no-link "$@"
    nix path-info "$@"
}

export NIX_SSHOPTS="-F $PWD/ssh_config -o UserKnownHostsFile=$(build '.#known-hosts')"
