{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/collab.nix
  ];

  age.secrets."collab-external-secrets" = {
    file = ../../secrets/collab-external-secrets.age;
    mode = "600";
    owner = "collab";
    group = "users";
  };

  networking.firewall.allowedTCPPorts = [22 80 8080 9100];

  noo.services.collab = {
    enable = true;
    host = "0.0.0.0";
    package = pkgs.collab-vr;
    jwtSecret = "mysecret";
    oidcIssuer = "https://login.lpm.feri.um.si/oidc";
    adminDefaultPassword = "myadmindefaultpass";
    externalSecretsFile = config.age.secrets."collab-external-secrets".path;
  };
}
