{config, lib, ...}:
{
  users.users.docker = {
    isNormalUser = true;
    description = "Docker user";
    extraGroups = ["docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga-docker];
  };
}
