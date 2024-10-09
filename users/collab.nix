{config, lib, ...}:
{
  users.users.collab = {
    isNormalUser = true;
    description = "Collaboration platform user";
    extraGroups = ["docker"];
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko merisa];
  };
}
