{config, lib, pkgs, ...}:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };

  boot.growPartition = true;
  boot.kernelParams = ["console=ttyS0"];
  services.acpid.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.timeout = 0;

  # Disable gtk (taken from amazon image) 
  services.udisks2.enable = false;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.kbdInteractiveAuthentication = false;
  services.openssh.openFirewall = false;

  # Prevent rescue user from logging in via SSH
  services.openssh.extraConfig = ''
    DenyUsers rescue
    AuthenticationMethods publickey
  '';

  # Take hostname from dhcpcd
  networking.hostName = mkDefault "";

  # Disable fonts (we don't have X)
  fonts.fontconfig.enable = mkDefault false;

  system.stateVersion = "21.05";

  system.build.image = import <nixpkgs/nixos/lib/make-disk-image.nix> {
    inherit lib config pkgs;
    diskSize = 8192;
    format = "qcow2";
  };
}
