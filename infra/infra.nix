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
          capacity = unit.GiB 16;
        }
        {
          name = "minimal";
          backing = "minimal-base-v2";
          capacity = unit.GiB 16;
        }
        {
          name = "proxy";
          backing = "minimal-base-v2";
          capacity = unit.GiB 16;
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
          capacity = unit.GiB 16;
        }
        {
          name = "login-dev";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "gc";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "gc-dev";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "catalog";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "catalog-dev";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "catalog-view";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "catalog-manage";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "catalog-manage-dev";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "catalog-summer-schools";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "catalog-mini-academy";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "bioma";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "ps";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "grades";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "grades-dev";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "feriusa";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "usatour";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
        {
          name = "collab-pora";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "collab-rri";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "collab-rsasm";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "collab-catalog-dev";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "collab-test";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "collab-vr";
          backing = "minimal-base-v3";
          capacity = unit.GiB 16;
        }
        {
          name = "school-project";
          backing = "minimal-base-v3";
          capacity = unit.GiB 8;
        }
      ];
    };
    "alternative2" = {
      start = true;
      autoStart = true;
      path = "/ssd2/libvirt/images";
      volumes = [
        {
          name = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "gateway";
          backing = "minimal-base-v2";
          capacity = unit.GiB 32;
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
            hostnames = [
              "dev.login.lpm.feri.um.si"
              "login.lpm.feri.um.si"
              "catalog.pmd.lpm.feri.um.si"
            ];
          }
        ];
      };
      prefixLength = 24;
      dhcp = {
        start = "10.17.3.2";
        end = "10.17.3.254";
        hosts = [
          {mac = "02:38:60:94:88:cc"; hostname = "spum-mqtt";     address = "10.17.3.111";}
          {mac = "02:a2:cd:0c:46:78"; hostname = "spum-platform"; address = "10.17.3.110";}
          {mac = "02:b2:a8:b4:1a:fd"; hostname = "ps-old";        address = "10.17.3.130";}
          {mac = "02:2a:89:07:ca:ef"; hostname = "gtpmas.l";      address = "10.17.3.173";}
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
          pool = "alternative2";
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
    "feriusa" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 5;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "feriusa";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "feriusa.l";
          address = "10.17.3.151";
        }
      ];
    };
    "usatour" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "usatour";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "usatour.l";
          address = "10.17.3.152";
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
    "grades" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "grades";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "grades.l";
          address = "10.17.3.121";
        }
      ];
    };
    "grades-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "grades-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "grades-dev.l";
          address = "10.17.3.122";
        }
      ];
    };
    "collab-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
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
    "collab-pora" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "collab-pora";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-pora.l";
          address = "10.17.3.214";
        }
      ];
    };
    "collab-rri" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "collab-rri";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-rri.l";
          address = "10.17.3.215";
        }
      ];
    };
    "collab-catalog-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "collab-catalog-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-catalog-dev.l";
          address = "10.17.3.216";
        }
      ];
    };
    "collab-test" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "collab-test";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-test.l";
          address = "10.17.3.217";
        }
      ];
    };
    "collab-vr" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "collab-vr";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-vr.l";
          address = "10.17.3.218";
        }
      ];
    };
    "collab-rsasm" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "collab-rsasm";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "collab-rsasm.l";
          address = "10.17.3.219";
        }
      ];
    };
    "gc" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
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
    "gc-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "gc-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "gc-dev.l";
          address = "10.17.3.192";
        }
      ];
    };
    "ps" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "ps";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "ps.l";
          address = "10.17.3.131";
        }
      ];
    };
    "catalog-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog-dev.l";
          address = "10.17.3.193";
        }
      ];
    };
    "catalog" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog.l";
          address = "10.17.3.194";
        }
      ];
    };
    "catalog-view" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog-view";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog-view.l";
          address = "10.17.3.195";
        }
      ];
    };
    "catalog-manage" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog-manage";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog-manage.l";
          address = "10.17.3.196";
        }
      ];
    };
    "catalog-manage-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog-manage-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog-manage-dev.l";
          address = "10.17.3.250";
        }
      ];
    };
    "catalog-summer-schools" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 4;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog-summer-schools";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog-summer-schools.l";
          address = "10.17.3.197";
        }
      ];
    };
    "catalog-mini-academy" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 4;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "catalog-mini-academy";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "catalog-mini-academy.l";
          address = "10.17.3.198";
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
    "login-dev" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "login-dev";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "login-dev.l";
          address = "10.17.3.213";
        }
      ];
    };
    "school-project" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 2;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "alternative";
          volume = "school-project";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "school-project.l";
          address = "10.17.3.223";
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
