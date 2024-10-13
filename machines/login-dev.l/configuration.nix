{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/login.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 3000 9100];

  age.secrets."login-dev-internal-secrets" = {
    file = ../../secrets/login-dev-internal-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."login-dev-external-secrets" = {
    file = ../../secrets/login-dev-external-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  noo.services.login = {
    enable = true;

    profilePictures = {
      enable = true;
      address = "https://dev.login.lpm.feri.um.si";
    };

    service = {
      enable = true;
      address = "https://dev.login.lpm.feri.um.si";
      internalSecretsFile = config.age.secrets.login-dev-internal-secrets.path;
      externalSecretsFile = config.age.secrets.login-dev-external-secrets.path;
    };
    database.enable = true;
  };
}
