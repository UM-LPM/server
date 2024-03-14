{...}:
{
  users.users.root.openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga marko viktor server-actions matej-extra];
}
