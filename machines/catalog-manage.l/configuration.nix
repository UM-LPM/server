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
      serverUrl = "https://scms.catalog.lpm.rwx.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      coursesUrl = "https://catalog.lpm.rwx.si/course-data.json";
      shortCoursesUrl = "https://catalog.lpm.rwx.si";
      clientId = "catalog-web-scms";
      issuerUri = "https://login.lpm.feri.um.si/oidc";
      redirectUriWeb = "https://scms.catalog.lpm.rwx.si/login";

      catalog = "katalog";
      getAll = "vse";
      login = "prijava";
    };
    coursePictures = {
      enable = true;
      address = "https://scms.catalog.lpm.rwx.si/images/";
    };
    backend = {
      enable = true;
      secrets = config.age.secrets."catalog-secrets".path;
      frontend = "https://scms.catalog.lpm.rwx.si";

      catalog = "katalog";
      login = "prijava";
    };
  };
}
