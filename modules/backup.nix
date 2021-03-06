{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.backup; 
in {
  options.backup = {
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
      timerConfig.OnCalendar = cfg.interval;
    };
    systemd.services.backup = {
      serviceConfig.Type = "oneshot";
      script = cfg.script;
    };
  };
}

