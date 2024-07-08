{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/grades.nix
  ];

  environment.systemPackages = [];
  networking.firewall.allowedTCPPorts = [22 80 3003 9100];

  noo.services.grades = {
    enable = true;
    frontend.enable = true;
    backend.enable = true;
    database.enable = true;
  };
}
