{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/root.nix
    ../../users/usatour.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80];
}
