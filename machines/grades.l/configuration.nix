{lib, config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/grades.nix
  ];

  environment.systemPackages = [];
  networking.firewall.allowedTCPPorts = [22 80 3003 9100];

  age.secrets."backup-rclone-config" = {
    file = ../../secrets/backup-rclone-config.age;
    mode = "600";
    owner = "grades";
    group = "users";
  };

  age.secrets."backup-password" = {
    file = ../../secrets/backup-password.age;
    mode = "600";
    owner = "grades";
    group = "users";
  };

  systemd.tmpfiles.settings = {
    "10-backup" = {
      "/var/lib/backup" = {
        d = {
          group = "users";
          mode = "0755";
          user = "grades";
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
    serviceConfig.User = "grades";
    script = ''
      ${pkgs.postgresql}/bin/pg_dump grades > /var/lib/backup/$(date --iso-8601=seconds).sql
    '';
  };

   systemd.tmpfiles.settings = {
    "10-restic" = {
      "/var/lib/restic" = {
        d = {
          group = "users";
          mode = "0755";
          user = "grades";
        };
      };
    };
  };
  services.restic.backups.remote = {
    passwordFile = config.age.secrets."backup-password".path;
    rcloneConfigFile = config.age.secrets."backup-rclone-config".path;
    initialize = true;
    repository = "rclone:database-backup:grades";

    timerConfig.OnCalendar = "daily";

    pruneOpts = [
      "--keep-daily 14"
      "--keep-weekly 4"
      "--keep-monthly 2"
    ];

    paths = [
      "/var/lib/restic/database.sql"
    ];
    backupPrepareCommand = ''
      ${lib.getExe pkgs.sudo} -u grades ${pkgs.postgresql}/bin/pg_dump > /var/lib/restic/database.sql
    '';
    backupCleanupCommand = ''
      rm /var/lib/restic/database.sql
    '';
  };

  age.secrets."grades-external-secrets" = {
    file = ../../secrets/grades-external-secrets.age;
    mode = "600";
    owner = "grades";
    group = "users";
  };

  noo.services.grades = {
    enable = true;
    frontend = {
      enable = true;
      serverUrl = "https://grades.lpm.feri.um.si/api";
      clientId = "grades";
      issuerUri = "https://login.lpm.feri.um.si/oidc";
      redirectUri = "https://grades.lpm.feri.um.si/auth.html";
    };
    backend.enable = true;
    database.enable = true;
    externalSecretsFile = config.age.secrets.grades-external-secrets.path;
  };
}
