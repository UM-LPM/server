{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../modules/docker-auto-clean.nix 
    ../../modules/backup.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/ps.nix
  ];

  environment.systemPackages = [pkgs.docker-compose];
  networking.firewall.allowedTCPPorts = [22 5050 9100];

  backup = {
    enabled = true;
    interval = "weekly";
    script = ''
      mkdir -p /var/lib/backup
      ${pkgs.python27Packages.rethinkdb}/bin/rethinkdb-dump -c localhost:48015 -f /var/lib/backup/$(date --iso-8601=seconds).tar.gz
    '';
  };
}
