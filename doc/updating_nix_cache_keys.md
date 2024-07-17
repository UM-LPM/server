# Updating the cache keys

1. Generate the keys
    ```bash
    nix-store --generate-binary-cache-key cache.lpm.feri.um.si cache-priv-key.pem cache-pub-key.pem
    ```
2. Replace the private key in ```secrets/cache-key.age```
3. Replace the public key in ```machines/runner1.l/configuration.nix```, ```machines/builder.l/configuration.nix```, ```.github/workflows/deploy-machine.yml```.
4. Replace the public key on all repositories that use the GitHub hosted runners.
5. Replace the public key on all development machines.

The instructions for replacing the key are at: https://cache.lpm.feri.um.si/

Verify that the cache works using:
```
nix store verify /nix/store/fz59zs6awmm3xflkfvwpg7546y7pyjz8-mongodb-4.4.25 --store https://cache.lpm.feri.um.si --trusted-public-keys [...]
```

There is a chance that negative caching on ```builder.l``` needs to be reset as well.
