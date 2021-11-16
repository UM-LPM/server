{config, pkgs, ...}:

let
  targets = [
    "localhost:9100"
    "gateway:9100"
    "builder:9100"
    "grades:9100"
    "spum-platform:9100"
    "spum-mqtt:9100"
    /* "spum-docker-registry:9100" */
    "ps:9100"
    "esp:9100"
    "usatour:9100"
    "calendar:9100"
    "win10hpc:9182"
    "prometheus:9100"
    "_gateway:9100" /* the host machine */
  ];
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.firewall.allowedTCPPorts = [22];
  
  services.grafana = {
    enable = true;
  };

  services.prometheus = {
    enable = true;

    globalConfig = {
      scrape_interval = "15s";
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [ 
          {
            inherit targets;
          }
        ];
      }
    ];
  };
}
