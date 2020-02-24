{...}:

{
  virtualisation.docker.enable = true;

  networking.firewall.allowedTCPPorts = [5000];
  docker-containers.docker-registry = {
    image = "registry:2";
    ports = ["5000:5000"];
  };
}
