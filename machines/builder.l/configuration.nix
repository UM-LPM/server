{config, pkgs, ...}:

let
  pubKey = "cache.lpm.feri.um.si:TwiF0KOXmbNihiysjGaH7EZOMHUvuwy+1mI/EHGc56M=";
  index = pkgs.writeTextFile {
    name = "index.html";

    text = ''
      <!DOCTYPE html>
      <html>
        <body>
          <h1>Cache</h1>

          <p>This is a binary cache for Nix packages.</p>

          <p>Public key: <code>${pubKey}</code></p>

          <h2>Using the cache</h2>
          <p>
            Add this to <code>/etc/nix/nix.conf</code>:
<pre><code>extra-substituters = https://cache.lpm.feri.um.si
extra-trusted-public-keys = ${pubKey}
trusted-substituters = https://cache.lpm.feri.um.si</code></pre>
          </p>
          <p>Restart the Nix daemon: <code>sudo pkill nix-daemon</code></p>
          <p>Reset negative caching: <code>rm $HOME/.cache/nix/binary-cache-v*.sqlite*</code></p>
        </body>
      </html>
    '';
  };
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  security.polkit.enable = true;
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;

  networking.firewall.allowedTCPPorts = [22 80];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [9100];

  age.secrets."cache-key".file = ../../secrets/cache-key.age;

  services.nix-serve = {
    enable = true;
    secretKeyFile = config.age.secrets.cache-key.path;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "$hostname" = {
        locations."/" = {
          priority = 0;
          root = pkgs.linkFarm "www" {
            "index.html" = index;
          };
          tryFiles = "$uri $uri/ @proxy";
        };
        locations."@proxy" = {
          recommendedProxySettings = true;
          proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
        };
      };
    };
  };
}
