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

  age.secrets."login-secrets" = {
    file = ../../secrets/login-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  noo.services.login = {
    enable = true;

    service = {
      enable = true;
      address = "https://login.lpm.feri.um.si";
      secretsFile = config.age.secrets.login-secrets.path;
    };
    database.enable = true;
  };
}
