{config, lib, ...}:
{
  users.users.mihaelhpc = {
    isNormalUser = true;
    description = "Miheal HPC user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga mihael];
  };
}
