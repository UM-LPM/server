{config, lib, ...}:
{
  users.users.prometheus = {
    isNormalUser = true;
    description = "Prometheus user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga mihael];
  };
}
