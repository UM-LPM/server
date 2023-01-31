{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  security.polkit.enable = true;
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;

  networking.firewall.allowedTCPPorts = [22];
}
