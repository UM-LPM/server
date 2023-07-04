{config, lib, ...}:
{
  users.users.kaze = {
    isNormalUser = true;
    description = "Kaze project user";
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej miha server-actions];
  };
}
