{...}:

assert false; # WARNING: This is just for last-ditch debugging using the console
{
  users.users.test = {
    isNormalUser = true;
    description = "Test user";
    extraGroups = ["wheel"];
    password = "test";
  };
}
