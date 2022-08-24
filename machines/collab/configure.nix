{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/collab.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];
}
