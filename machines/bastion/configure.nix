{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/user.nix
    ../../users/root.nix
  ];

  users.users.test = {
    isNormalUser = true;
    description = "Test user";
    extraGroups = ["wheel"];
    password = "test";
  };

  networking = {
    interfaces.ens4 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "164.8.230.209";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "164.8.230.1";
      interface = "ens4";
      metric = 0;
    };
  };
}
