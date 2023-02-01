{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/mihaelhpc.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];

  fileSystems."/data" = {
    device = "/dev/disk/by-label/data";
    autoResize = true;
    fsType = "ext4";
    options = ["nofail"];
  };
  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
