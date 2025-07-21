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

  age.secrets."collab-external-secrets" = {
    file = ../../secrets/collab-external-secrets.age;
    mode = "600";
    owner = "collab";
    group = "users";
  };

  noo.services.collab = {
    enable = true;
    host = "0.0.0.0";
    package = pkgs.collab-catalog-dev;
    jwtSecret = "mysecret";
    oidcIssuer = "https://dev.login.lpm.feri.um.si/oidc";
    oidcIssuer = "https://login.lpm.feri.um.si/oidc";
    adminDefaultPassword = "myadmindefaultpass";
  };
}
