{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 9100];

  age.secrets."sloncek-secrets" = {
    file = ../../secrets/sloncek-secrets.age;
    mode = "600";
    owner = "sloncek";
    group = "sloncek";
  };

  noo.services.sloncek = {
    enable = true;
    domain = "sloncek.feri.um.si";
    backend.secrets = config.age.secrets."sloncek-secrets".path;
  };
}
