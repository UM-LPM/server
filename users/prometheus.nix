{config, lib, ...}:
{
  users.users.monitor = {
    isNormalUser = true;
    description = "Monitoring user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga miha matej];
  };
}
