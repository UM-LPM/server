{config, lib, ...}:
{
  security.sudo.wheelNeedsPassword = false;
  users.users.gb = {
    isNormalUser = true;
    description = "Game backend user";
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej matej-actions gb];
  };
}
