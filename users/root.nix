{...}:
{
  users.users.root.openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga ziga-actions];
}
