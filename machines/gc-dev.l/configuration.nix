{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/gc.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 8080 9100];

  age.secrets."gc-secrets" = {
    file = ../../secrets/gc-secrets.age;
    mode = "600";
    owner = "gc";
    group = "users";
  };

  lpm.services.gc = {
    enable = true;
    host = "0.0.0.0";
    secretsFile = config.age.secrets.gc-secrets.path;
  };
}
