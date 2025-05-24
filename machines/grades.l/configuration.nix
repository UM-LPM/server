{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/grades.nix
  ];

  age.secrets."grades-external-secrets" = {
    file = ../../secrets/grades-external-secrets.age;
    mode = "600";
    owner = "grades";
    group = "users";
  };

  environment.systemPackages = [];
  networking.firewall.allowedTCPPorts = [22 80 3003 9100];

  noo.services.grades = {
    enable = true;
    frontend.enable = true;
    backend.enable = true;
    database.enable = true;
    externalSecretsFile = config.age.secrets."grades-external-secrets".path;
  };
}
