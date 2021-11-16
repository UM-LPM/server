{...}:

{
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [
      "disable-defaults"
      "filesystem"
      "meminfo"
      "cpu"
      "loadavg"
      "netdev"
      "diskstats"
    ];
  };
}
