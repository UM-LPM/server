{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/gb.nix
  ];
  
  environment.systemPackages = [pkgs.docker-compose];
  networking.firewall.allowedTCPPorts = [22 8080 5050 9100];
}
