{config, pkgs, ...}:
{
  imports = [
    ../../modules/image.nix
    ../../users/user.nix
    ../../users/docker.nix
  ];

  networking.hostName = "docker-host";
  virtualisation.docker.enable = true;
}
