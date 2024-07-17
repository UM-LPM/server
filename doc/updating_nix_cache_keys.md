# Updating the cache keys

1. Generate the keys
```bash
nix-store --generate-binary-cache-key cache.lpm.feri.um.si cache-priv-key.pem cache-pub-key.pem
```

2. Replace ```secrets/cache-key.age``` with ```cache-priv-key.pem```
3. 
