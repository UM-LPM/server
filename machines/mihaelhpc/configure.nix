{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/user.nix
    ../../users/mihaelhpc.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];
  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
