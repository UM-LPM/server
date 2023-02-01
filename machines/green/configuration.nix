{ config, pkgs, ... }:

let 
  webConfig = pkgs.writeTextFile {
    name = "web-config.yml";
    text = ''
    tls_server_config:
      #cert_file: <filename>
      #key_file: <filename>

      client_auth_type: "RequireAndVerifyClientCert"
      client_ca_file: "/etc/ssl/certs/prometheus.crt"
    '';
  };
in
{
  imports = [
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/green.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = ["msr"];

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [neovim];

  networking = {
    firewall.allowedTCPPorts = [9100];
  
    hostName = "green";
    nameservers = ["1.1.1.1"];

    interfaces.eno1 = {
      useDHCP = false;
      ipv4.addresses = [
        {address = "164.8.230.240"; prefixLength = 24;}
      ];
    };
    
    defaultGateway = {
      address = "164.8.230.1";
      interface = "eno1";
    };
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
  

  
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
    extraFlags = [
      "--web.config.file=${webConfig}"
    ];
  };

  systemd.services.green = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "Start the green service";
    environment = {
      JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    };
    serviceConfig = {
      Type = "simple";
      User = "root";
      Restart = "always";
      ExecStart = "/home/green/green/bin/green";
    };
  };

  system.stateVersion = "22.05";
}

