{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/spum.nix
  ];
  
  environment.systemPackages = [pkgs.docker-compose];

  networking.firewall.allowedTCPPorts = [22 80 5000 9100];
}
