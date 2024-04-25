# Secrets

[agenix](https://github.com/ryantm/agenix)

```
nix run github:ryantm/agenix -- -i {{path to private key}} -e {{file}}.age
```

```
nix run github:ryantm/agenix -- -i ~/.ssh/lpm -e gc-secrets.age
```

## Install

```
nix profile install github:ryantm/agenix
```

```
agenix -i {{path to private key}} -e {{file}}.age
```
