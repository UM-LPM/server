{config, lib, ...}:
{
  security.sudo.wheelNeedsPassword = false;
  users.users.grades = {
    isNormalUser = true;
    description = "Grading app";
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga matej mario];
  };
}
