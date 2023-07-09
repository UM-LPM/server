{unit, ...}:
{
  pools = {
    "default" = {
      start = true;
      autoStart = true;
      path = "/var/lib/libvirt/images";
      volumes = [
        {
          name = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "bastion-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "bastion";
          backing = "bastion-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "gateway";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "builder";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "prometheus";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "minimal";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "proxy";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "calendar";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "sso-test";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "student-mqtt";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "kaze";
          backing = "minimal-base-v2";
          capacity = unit.GiB 16;
        }
        {
          name = "collab";
          backing = "minimal-base-v2";
          capacity = unit.GiB 16;
        }
        {
          name = "collab-dev";
          backing = "minimal-base-v2";
          capacity = unit.GiB 16;
        }
      ];
    };
  };

  networks = {
    "private-network" = {
      start = true;
      autoStart = true;
      bridge = "vprivate";
      address = "10.17.3.1";
      dns = "8.8.8.8";
      prefixLength = 24;
      dhcp = {
        start = "10.17.3.2";
        end = "10.17.3.254";
        hosts = [
          {mac = "02:a2:cd:0c:46:78"; hostname = "spum-platform"; address = "10.17.3.110";}
          {mac = "02:c4:28:97:46:27"; hostname = "grades";        address = "10.17.3.120";}
          {mac = "02:17:14:14:5a:c4"; hostname = "ps";            address = "10.17.3.130";}
          {mac = "02:aa:bc:09:52:6d"; hostname = "esp";           address = "10.17.3.140";}
          {mac = "02:59:e1:4f:03:bf"; hostname = "usatour";       address = "10.17.3.150";}
          {mac = "02:a5:f8:7e:1d:b3"; hostname = "bioma";         address = "10.17.3.180";}
          {mac = "02:af:e7:1b:e5:de"; hostname = "gb";            address = "10.17.3.190";} 
          {mac = "02:33:74:0c:86:ee"; hostname = "ears";          address = "10.17.3.200";}
        ];
      };
    };
  };

  domains = {
    "bastion" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "bastion";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "bastion.l";
          address = "10.17.3.100";
        }
      ];
      directInterfaces = [
        {
          device = "eno1";
        }
      ];
    };
    "gateway" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "gateway";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "gateway.l";
          address = "10.17.3.101";
        }
      ];
      directInterfaces = [
        {
          device = "eno1";
        }
      ];
    };
    "builder" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 10;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "builder";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "builder.l";
          address = "10.17.3.102";
        }
      ];
    };
    "prometheus" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "prometheus";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "prometheus.l";
          address = "10.17.3.103";
        }
      ];
    };
    "minimal" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "minimal";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "minimal.l";
          address = "10.17.3.220";
        }
      ];
    };
    "sso-test" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "sso-test";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "sso-test.l";
          address = "10.17.3.222";
        }
      ];
    };
    "proxy" = {
      start = true;
      autoStart = true;
      memory = unit.MiB 500;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "proxy";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "proxy.l";
          address = "10.17.3.221";
          bandwidth = {
            inbound = {average = unit.MB 4; burst = unit.MiB 10;};
            outbound = {average = unit.MB 4; burst = unit.MiB 10;};
          };
        }
      ];
    };
    "calendar" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "calendar";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "calendar.l";
          address = "10.17.3.160";
        }
      ];
    };
    "student-mqtt" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "student-mqtt";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "student-mqtt.l";
          address = "10.17.3.230";
        }
      ];
    };
    "kaze" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 100;
      vcpu = 32;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "kaze";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "kaze.l";
          address = "10.17.3.240";
        }
      ];
    };
    "collab" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "collab";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab.l";
          address = "10.17.3.210";
        }
      ];
    };
    "collab-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "collab-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-dev.l";
          address = "10.17.3.211";
        }
      ];
    };
  };
}
