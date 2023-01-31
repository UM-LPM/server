{config, lib, pkgs, ...}:
{
  users.users.proxy = {
    isNormalUser = true;
    description = "Proxy user";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga bostjan];
  };
}
