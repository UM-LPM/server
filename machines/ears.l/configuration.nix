{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/ears.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];
}
