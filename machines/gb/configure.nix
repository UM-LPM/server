{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/user.nix
    ../../users/gb.nix
  ];

  networking.firewall.allowedTCPPorts = [22 5050 9100];
}
