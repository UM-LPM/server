{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.backup; 
in {
  options = {
    enabled = mkEnableOption "Backup machine";
    interval = mkOption {
      type = types.str;
      description = "Backup interval";
    };
    script = mkOption {
      type = types.str;
      description = "Backup script to run";
    };
  };
  config = {
    systemd.timers.backup = {
      wantedBy = [ "timers.target" ];
      partOf = [ "backup.service" ];
      timerConfig.OnCalendar = cfg.when;
    };
    systemd.services.backup = {
      serviceConfig.Type = "oneshot";
      script = cfg.script;
    };
  };
}

