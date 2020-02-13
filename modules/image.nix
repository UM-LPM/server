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
  boot.initrd.availableKernelModules = ["virtio_balloon" "virtio_blk" "virtio_pci" "virtio_ring"];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout = 0;

  services.udisks2.enable = false;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  system.build.image = import <nixpkgs/nixos/lib/make-disk-image.nix> {
    inherit lib config pkgs;
    diskSize = 8192; # XXX: This probably shouldn't be hard coded?
    format = "qcow2";
  };
}
