{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/bridge.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/bastion.nix
  ];

  networking.bridge = {
    interface = "ens3";

    addresses = [ 
      {
        address = "164.8.230.209";
        prefixLength = 24;
      }
    ];

    defaultGateway = {
      address = "164.8.230.1";
    };
  };

  environment.etc."nologin.txt".source = pkgs.writeText "init-file" ''NOLOGIN'';

  services.openssh.extraConfig = ''
    AllowTcpForwarding yes
    PermitOpen *:22
    X11Forwarding no
    PermitTunnel no
    GatewayPorts no

    Match User bastion
      PermitTTY no
  '';

  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [9100];
}
