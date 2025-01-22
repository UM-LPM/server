{config, pkgs, ...}:

let
  view = pkgs.callPackage ./view.nix {};
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/catalog.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80];

  services.nginx.enable = true;
  services.nginx.virtualHosts."$hostname" = {
    root = view;
  };
}
