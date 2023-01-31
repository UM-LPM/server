{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/sso-test.nix
  ];

  networking.firewall.allowedTCPPorts = [22];
}
