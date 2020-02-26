# Adding users

1. Create ```/users/<user>.nix``` with the following contents:
```Nix
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

2. Import the ```<user>.nix``` module in ```/machines/bastion.nix``` and other desired machines
