{config, lib, ...}:
{
  users.users.bass = {
    isNormalUser = true;
    description = "Bass forwarding user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [bass-actions];
  };
}
