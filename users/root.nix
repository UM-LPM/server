{...}:
{
  users.users.root.openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga marko server-actions];
}
