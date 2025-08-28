{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/catalog.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8000 8080 8081 9100];

  age.secrets."catalog-secrets" = {
    file = ../../secrets/catalog-secrets.age;
    mode = "600";
    owner = "catalog";
    group = "users";
  };

  noo.services.catalog = {
    enable = true;

    frontendManage = {
      enable = true;
      serverUrl = "https://upravljanje-katalog.lpm.feri.um.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      coursesUrl = "https://upravljanje.poletne-sole.feri.um.si/course-data.json";
      shortCoursesUrl = "https://poletne-sole.feri.um.si";
      clientId = "catalog-web-scms";
      issuerUri = "https://login.lpm.feri.um.si/oidc";
      redirectUriWeb = "https://upravljanje-katalog.lpm.feri.um.si/login";
    };
    coursePictures = {
      enable = true;
      address = "https://upravljanje-katalog.lpm.feri.um.si/";
    };
    backend = {
      enable = true;
      secrets = config.age.secrets."catalog-secrets".path;
      frontend = "https://upravljanje-katalog.lpm.feri.um.si";

      catalog = "katalog";
      login = "prijava";
    };
  };
}
