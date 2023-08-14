{config, lib, ...}:
{
  users.users.runner = {
    isNormalUser = true;
    description = "Runner user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko];
  };
}
