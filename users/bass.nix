{config, lib, ...}:
{
  users.users.bass = {
    isNormalUser = true;
    description = "Bass user (forwarding)";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [bass-actions];
  };
}
