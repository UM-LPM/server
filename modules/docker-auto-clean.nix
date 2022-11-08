{ pkgs, ... }:

{
  systemd = {
    timers.docker-auto-clean = {
      wantedBy = ["timers.target"];
      partOf = ["docker-auto-clean.service"];
      timerConfig.OnCalendar = "daily";
    };
    services.docker-auto-clean = {
      serviceConfig.Type = "oneshot";
      script = ''
        docker system prune -f --filter "until=720h"
      '';
    };
  };
}
