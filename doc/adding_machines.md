## Access to Server

Access to the server is required before proceeding with any of the steps below.



## 1. Infrastructure Setup

### Adding a Volume to a Pool

There are three existing pools — each is a disk with an image set at a specific path. Each pool contains multiple volumes.

| Pool | Status |
|------|--------|
| `default` | Nearly full — limited space to increase size |
| `alternative` | Nearly full — limited space to increase size |
| `alternative2` | Free pool — use this if needed |

- If volumes need to be moved, migrate them to `alternative2`.

### Choosing a Base Image

- Use **v4** (recommended) — v2 is the older image.
- The VM operates using the base image and applies overlay image changes on top.
- The backing image **must be in the same pool** as the VM — it cannot reference a pool that differs.
- Generate the base image inside the target pool before creating the VM.
- Different pools use different version naming to keep images organized.
- A new image version = new version of NixOS packages.

**Relevant scripts:**

| Script | Purpose |
|--------|---------|
| `build.sh` | Builds an image for the NixOS configuration |
| `deploy.sh` | Downloads and installs new packages (deploys NixOS configuration) |

### Uploading the Volume

After building the image, upload it to the pool:

```bash
vol-upload --pool alternative2 minimal-base-v4 --file result/nixos.qcow2
```


## 2. Network Configuration

- To resolve URLs inside the VM, add the domain to **network hosts** in the private network section of the config.
- Each VM's address in **Network Interfaces must be unique**.



## 3. VM Configuration (`infra.nix`)

1. Add the VM configuration under `domains` in `infra.nix`.
2. Set a unique address in **Network Interfaces**.
3. After editing, generate the deployment bash script:

```bash
nix-build -A config.toplevel gen.nix -I infra=./infra.nix
```


## 4. Deployment

### SSH Access

Assign server SSH access to the user deploying the script (inside `infra/result`).

Set up the SSH agent and add your key:

```bash
eval $(ssh-agent)
ssh-add ~/.ssh/lpm
```

### Machine Configuration

1. Once the script is built, create a config for the new machine inside the `machines/` folder.
2. Use the **same name as the hostname** defined in `infra.nix`.
3. Create a folder with that hostname and add the proper NixOS configuration.

### Systems — SSH Public Key

In `systems`, add the SSH public key for the VM's hostname.

### GitHub Access Token

Add the access token to the NixOS config with the `github:` prefix:

```
access-tokens = github.com=TOKEN
```

### Verification

Before committing changes, SSH into the VM to verify it was created successfully.

### Deploy Script

Add the hostname to the deploy script on the server so the VM is deployed alongside other machines.