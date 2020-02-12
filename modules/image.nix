{config, lib, pkgs, ...}:

with lib;

{
  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };

    boot.growPartition = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.initrd.availableKernelModules = ["virtio_balloon" "virtio_blk" "virtio_pci" "virtio_ring"];

    system.build.image = import <nixpkgs/nixos/lib/make-disk-image.nix> {
      inherit lib config pkgs;

      partitionTableType = "legacy";
      diskSize = 8192; # XXX: This probably shouldn't be hard coded?
      format = "qcow2";
    };
  };
}
