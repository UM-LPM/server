{ config, pkgs, ... }:

{
  imports = [
    ../../users/root.nix
    ../../users/user.nix
    ../../users/aeneas.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = ["msr"];

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [neovim];

  networking = {
    hostName = "aeneas";
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

  system.stateVersion = "22.05";
}

