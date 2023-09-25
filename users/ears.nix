{config, lib, ...}:
{
  users.users.ears = {
    isNormalUser = true;
    description = "EARS user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga miha];
  };
}
