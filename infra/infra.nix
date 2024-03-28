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
          capacity = unit.GiB 32;
        }
        {
          name = "runner2";
          backing = "minimal-base-v2";
          capacity = unit.GiB 32;
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
    "alternative" = {
      start = true;
      autoStart = true;
      path = "/ssd1/libvirt/images";
      volumes = [
        {
          name = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "runner1";
          backing = "minimal-base-v3";
          capacity = unit.GiB 64;
        }
        {
          name = "ears-legacy-base";
          capacity = unit.GiB 8;
        }
        {
          name = "ears-legacy";
          backing = "ears-legacy-base";
          capacity = unit.GiB 8;
        }
        {
          name = "ears";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "login";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "gc";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "pmd-catalog";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "bioma";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
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
      dns = {
        address = "8.8.8.8";
        hosts = [
          {
            address = "10.17.3.101";
            hostnames = ["login.lpm.feri.um.si"];
          }
        ];
      };
      prefixLength = 24;
      dhcp = {
        start = "10.17.3.2";
        end = "10.17.3.254";
        hosts = [
          {mac = "02:38:60:94:88:cc"; hostname = "spum-mqtt";        address = "10.17.3.111";}
          {mac = "02:a2:cd:0c:46:78"; hostname = "spum-platform";    address = "10.17.3.110";}
          {mac = "02:c4:28:97:46:27"; hostname = "grades";           address = "10.17.3.120";}
          {mac = "02:17:14:14:5a:c4"; hostname = "ps";               address = "10.17.3.130";}
          {mac = "02:aa:bc:09:52:6d"; hostname = "esp";              address = "10.17.3.140";}
          {mac = "02:59:e1:4f:03:bf"; hostname = "usatour";          address = "10.17.3.150";}
          {mac = "02:a5:f8:7e:1d:b3"; hostname = "bioma";            address = "10.17.3.180";}
          {mac = "02:2a:89:07:ca:ef"; hostname = "gtpmas.l";         address = "10.17.3.173";}
          {mac = "02:94:78:76:bd:6b"; hostname = "prometheus-old.l"; address = "10.17.3.107";}
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
      memory = unit.GiB 32;
      vcpu = 16;
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
    "runner1" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 32;
      vcpu = 8;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "runner1";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "runner1.l";
          address = "10.17.3.104";
        }
      ];
    };
    "runner2" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 32;
      vcpu = 8;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "runner2";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "runner2.l";
          address = "10.17.3.105";
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
    "bioma" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "bioma";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "bioma.l";
          address = "10.17.3.181";
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
    "gc" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "gc";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "gc.l";
          address = "10.17.3.191";
        }
      ];
    };
    "pmd-catalog" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "pmd-catalog";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "pmd-catalog.l";
          address = "10.17.3.192";
        }
      ];
    };
    "login" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "login";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "login.l";
          address = "10.17.3.212";
        }
      ];
    };
    "ears" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 10;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "ears";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "ears.l";
          address = "10.17.3.200";
        }
      ];
    };
    "ears-legacy" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 10;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "ears-legacy";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "ears-legacy.l";
          address = "10.17.3.201";
        }
      ];
    };
  };
}
