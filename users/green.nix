{config, lib, ...}:
{
  users.users.green = {
    isNormalUser = true;
    description = "Green project user";
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga ziga-green matej server-actions miha];
  };
}
