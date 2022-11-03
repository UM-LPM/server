{pkgs, config, modulesPath, ...}:
{
  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
  ];

  networking = {
    hostName = "aeneas-workstation";
    nameservers = ["1.1.1.1"];

    interfaces.eno1 = {
      useDHCP = false;
      ipv4.addresses = [
        {address = "164.8.230.241"; prefixLength = 24;}
      ];
    };
    defaultGateway = {
      address = "164.8.230.1";
      interface = "eno1";
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    neovim
    jetbrains.idea-community
    git
    wget
    jdk
    gradle
    gcc
  ];


  # EFI booting
  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

  system.stateVersion = "22.05";
}
