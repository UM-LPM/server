{config, pkgs, ...}:

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
