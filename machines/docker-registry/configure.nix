{config, pkgs, ...}:
{
  imports = [
    ../../modules/image.nix
    ../../users/user.nix
  ];

  networking.hostName = "docker-registry";
  virtualisation.docker.enable = true;

  networking.firewall.allowedTCPPorts = [5000];
  docker-containers.docker-registry = {
    image = "registry:2";
    ports = ["5000:5000"];
  };

  /*systemd.services.setup-docker-registry = {
    wantedBy = [ "multi-user.target" ];
    requires = ["network-online.target" "docker.service"];
    after = ["network-online.target" "docker.service"];
    serviceConfig.Type = "oneshot";

    script = ''
       docker run -d -p 5000:5000 --restart=always --name registry registry:2
    '';
  };*/
}
