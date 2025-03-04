{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/feriusa.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 9100 9113];
  services.prometheus.exporters.nginx.enable = true;
  services.nginx.statusPage = true;
}
