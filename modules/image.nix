{config, lib, pkgs, ...}:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/profiles/headless.nix>
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };

  boot.growPartition = true;
  #boot.kernelParams = ["console=ttyS0"];
  boot.initrd.availableKernelModules = ["virtio_balloon" "virtio_blk" "virtio_pci" "virtio_ring"];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout = 0;

  # Disable gtk (taken from amazon image) 
  services.udisks2.enable = false;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.openFirewall = false;

  # Take hostname from dhcpcd
  networking.hostName = mkDefault "";

  # Disable fonts (we don't have X)
  fonts.fontconfig.enable = false;

  system.build.image = import <nixpkgs/nixos/lib/make-disk-image.nix> {
    inherit lib config pkgs;
    diskSize = 8192; # XXX: This probably shouldn't be hard coded? The qcow2 is compressed, which means there is no much difference though
    format = "qcow2";
  };
}
