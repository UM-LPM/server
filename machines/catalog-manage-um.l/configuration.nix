{config, pkgs, lib, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/catalog.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8000 8080 8081 9100];

   systemd.tmpfiles.settings = {
    "10-backup" = {
      "/var/lib/backup" = {
        d = {
          group = "users";
          mode = "0755";
          user = "catalog";
        };
      };
    };
  };
  systemd.timers.backup = {
    wantedBy = [ "timers.target" ];
    partOf = [ "backup.service" ];
    timerConfig.OnCalendar = "daily";
  };
  systemd.services.backup = {
    serviceConfig.Type = "oneshot";
    serviceConfig.User = "catalog";
    script = ''
      ${pkgs.postgresql}/bin/pg_dump catalog > /var/lib/backup/$(date --iso-8601=seconds).sql
    '';
  };

  age.secrets."catalog-secrets" = {
    file = ../../secrets/catalog-secrets.age;
    mode = "600";
    owner = "catalog";
    group = "users";
  };

  age.secrets."backup-rclone-config" = {
    file = ../../secrets/backup-rclone-config.age;
    mode = "600";
    owner = "catalog";
    group = "users";
  };

  age.secrets."backup-password" = {
    file = ../../secrets/backup-password.age;
    mode = "600";
    owner = "catalog";
    group = "users";
  };

   systemd.tmpfiles.settings = {
    "10-restic" = {
      "/var/lib/restic" = {
        d = {
          group = "users";
          mode = "0755";
          user = "catalog";
        };
      };
    };
  };
  services.restic.backups.remote = {
    passwordFile = config.age.secrets."backup-password".path;
    rcloneConfigFile = config.age.secrets."backup-rclone-config".path;
    initialize = true;
    repository = "rclone:database-backup:catalog-manage-um";

    timerConfig.OnCalendar = "daily";

    pruneOpts = [
      "--keep-daily 14"
      "--keep-weekly 4"
      "--keep-monthly 2"
    ];

    paths = [
      "/var/lib/pictures/"
      "/var/lib/restic/database.sql"
    ];
    backupPrepareCommand = ''
      ${lib.getExe pkgs.sudo} -u catalog ${pkgs.postgresql}/bin/pg_dump > /var/lib/restic/database.sql
    '';
    backupCleanupCommand = ''
      rm /var/lib/restic/database.sql
    '';
  };

  noo.services.catalog = {
    enable = true;

    frontendManage = {
      enable = true;
      serverUrl = "https://upravljanje-katalog.um.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      coursesUrl = "https://upravljanje.krajsa-izobrazevanja.um.si/course-data.json";
      shortCoursesUrl = "https://krajsa-izobrazevanja.um.si";
      clientId = "catalog-web-scms-um";
      issuerUri = "https://login.lpm.feri.um.si/oidc";
      redirectUriWeb = "https://upravljanje-katalog.um.si/login";
    };
    coursePictures = {
      enable = true;
      address = "https://upravljanje-katalog.um.si/";
    };
    backend = {
      enable = true;
      secrets = config.age.secrets."catalog-secrets".path;
      frontendManage = "https://upravljanje-katalog.um.si";

      catalog = "katalog";
      login = "prijava";
    };
  };
}
