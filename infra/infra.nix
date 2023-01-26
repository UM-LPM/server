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
          pool = "images";
          volume = "minimal";
        }
      ];
      interfaces = [
        {
          network = "private-network";
          hostname = "minimal";
          address = "10.17.3.220";
        }
      ];
    };
  };
}
