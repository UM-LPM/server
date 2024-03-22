{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/catalog.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 8080 9100];

  age.secrets."pmd-catalog-secrets" = {
    file = ../../secrets/pmd-catalog-secrets.age;
    mode = "600";
    owner = "catalog";
    group = "users";
  };

  noo.services.pmdCatalog = {
    enable = true;
    secrets = config.age.secrets."pmd-catalog-secrets".path;
  };
}
