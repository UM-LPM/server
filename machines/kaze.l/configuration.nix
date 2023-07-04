{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/kaze.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];
}
