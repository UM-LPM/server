{config, pkgs, ...}:

{
  imports = [
    <nixpkgs/nixos/modules/profiles/headless.nix>
    ../../modules/git-deploy.nix
    ../../modules/image.nix
    ../../users/user.nix
  ];

  virtualisation.docker.enable = true;
  services.sshd.enable = true;
}
