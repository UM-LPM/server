{...}:

{
  services.prometheus.exporters.node = {
    enable = true;
    extraFlags = ["--collector.disable-defaults"];
    enabledCollectors = [
      "filesystem"
      "meminfo"
      "cpu"
      "loadavg"
      "netdev"
      "diskstats"
    ];
  };
}
