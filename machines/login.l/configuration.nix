{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/login.nix
  ];

  networking.firewall.allowedTCPPorts = [22 3000 9100];

  age.secrets."login-internal-secrets" = {
    file = ../../secrets/login-internal-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."login-external-secrets" = {
    file = ../../secrets/login-external-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  noo.services.login = {
    enable = true;

    service = {
      enable = true;
      address = "https://login.lpm.feri.um.si";
      internalSecretsFile = config.age.secrets.login-internal-secrets.path;
      externalSecretsFile = config.age.secrets.login-external-secrets.path;
    };
    database.enable = true;
  };
}
