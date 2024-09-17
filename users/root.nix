{...}:
{
  users.users.root.openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga marko server-actions matej-extra cvetanka];
}
