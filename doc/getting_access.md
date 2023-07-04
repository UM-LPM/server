# Getting access

1. Run ```ssh-keygen -t ed25519```
2. Add your *public* key to ```ssh/users.nix```
3. Add your key to ```openssh.authorizedKeys.keys``` for desired users in folder ```users/``` (for example for spum in file ```users/spum.nix```)
