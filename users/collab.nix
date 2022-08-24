{config, lib, ...}:
{
  users.users.collab = {
    isNormalUser = true;
    description = "Collaboration platform user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej];
  };
}
