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

  age.secrets."grades-dev-external-secrets" = {
    file = ../../secrets/grades-dev-external-secrets.age;
    mode = "600";
    owner = "grades";
    group = "users";
  };

  noo.services.grades = {
    enable = true;
    frontend = {
      enable = true;
      serverUrl = "https://dev.grades.lpm.feri.um.si/api";
      clientId = "grades-dev";
      issuerUri = "https://login.lpm.feri.um.si/oidc";
      redirectUri = "https://dev.grades.lpm.feri.um.si/auth.html";
    };
    backend.enable = true;
    database.enable = true;
    externalSecretsFile = config.age.secrets.grades-dev-external-secrets.path;
  };
}
