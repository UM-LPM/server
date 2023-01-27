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
          name = "minimal";
          backing = "minimal-base-v2";
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
      dns = "8.8.8.8";
      prefixLength = 24;
      dhcp = {
        start = "10.17.3.2";
        end = "10.17.3.254";
        hosts = [
          {mac = "02:fe:9e:a7:5b:30"; hostname = "bastion";       address = "10.17.3.100";}
          {mac = "02:63:81:cd:d5:b8"; hostname = "gateway";       address = "10.17.3.101";}
          {mac = "02:ef:7e:cb:54:3e"; hostname = "builder";       address = "10.17.3.102";}
          {mac = "02:e7:8b:d7:4e:8a"; hostname = "prometheus";    address = "10.17.3.103";}
          {mac = "02:a2:cd:0c:46:78"; hostname = "spum-platform"; address = "10.17.3.110";}
          {mac = "02:38:60:94:88:cc"; hostname = "spum-mqtt";     address = "10.17.3.111";}
          {mac = "02:c4:28:97:46:27"; hostname = "grades";        address = "10.17.3.120";}
          {mac = "02:17:14:14:5a:c4"; hostname = "ps";            address = "10.17.3.130";}
          {mac = "02:aa:bc:09:52:6d"; hostname = "esp";           address = "10.17.3.140";}
          {mac = "02:59:e1:4f:03:bf"; hostname = "usatour";       address = "10.17.3.150";}
          {mac = "02:f8:82:8b:50:d9"; hostname = "calendar";      address = "10.17.3.160";}
          {mac = "02:1c:05:6b:6e:fb"; hostname = "win10hpc";      address = "10.17.3.170";}
          {mac = "02:4a:24:fe:f5:39"; hostname = "mihaelhpc";     address = "10.17.3.171";}
          {mac = "02:a5:f8:7e:1d:b3"; hostname = "bioma";         address = "10.17.3.180";}
          {mac = "02:af:e7:1b:e5:de"; hostname = "gb";            address = "10.17.3.190";} 
          {mac = "02:33:74:0c:86:ee"; hostname = "ears";          address = "10.17.3.200";}
          {mac = "02:da:bb:9f:f8:54"; hostname = "collab";        address = "10.17.3.210";}
        ];
      };
    };
  };

  domains = {
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
      interfaces = [
        {
          network = "private-network";
          hostname = "minimal.lpm";
          address = "10.17.3.220";
        }
      ];
    };
  };
}
