{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/collab.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 8080 9100];

  noo.services.collab = {
    enable = true;
    isDevelopment = true;
    jwtSecret = "mysecret";
    adminDefaultPassword = "myadmindefaultpass";
  };
}
