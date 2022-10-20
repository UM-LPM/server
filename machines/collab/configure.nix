{config, pkgs, ...}:

let
  pinpkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "c5924154f000e6306030300592f4282949b2db6c";
    sha256 = "0idnlkn01d43hsb9rgnvngvvaphzirhifzq5hx57drpg28f63l9q";
  }) {};
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    #../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/user.nix
    ../../users/collab.nix
  ];

  environment.systemPackages = [pkgs.docker-compose pinpkgs.flutter pinpkgs.dart pkgs.git pkgs.neovim];
  networking.firewall.allowedTCPPorts = [22 8080 9100];
}
