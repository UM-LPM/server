#export NIX_SSHOPTS="-F $PWD/ssh_config -o UserKnownHostsFile=$PWD/known_hosts/known_hosts" 
export NIX_SSHOPTS="-F $PWD/ssh_config -o StrictHostKeyChecking=no" 
export NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz"
