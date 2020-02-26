# Adding users

1. Create ```/users/<user>``` with the following contents:
```
{config, lib, ...}:
{
  users.users.<user> = {
    isNormalUser = true;
    description = "<description>";
    extraGroups = [<groups...>];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [<keys...>];
  };
}
```
