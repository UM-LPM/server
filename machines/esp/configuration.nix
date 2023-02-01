{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/esp.nix
  ];
  
  environment.systemPackages = [pkgs.docker-compose];

  networking.firewall.allowedTCPPorts = [22 80 9100];
}
