{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.firewall.allowedTCPPorts = [22];
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;
}
