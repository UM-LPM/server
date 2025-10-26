{config, lib, ...}:
{
  users.users.grades = {
    isNormalUser = true;
    description = "Grading app";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [ziga matej mario domen];
  };
}
