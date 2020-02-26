# Adding machines

1. Add a new folder to ```/machines/```
2. Write ```configuration.nix```
3. Build the image by running:
```
nix-build '<nixpkgs/nixos>' -A config.system.build.image -I nixos-config=configure.nix
```

4. Add the path to the base image to ```image_paths``` in ```/infra/modules/images/main.tf```
5. Add the ip to ```hosts``` in ```/infra/modules/network/variables.tf```

6. Create a new folder in ```/infra/modules```
7. Put the following to ```variables.tf```:
```
variable "global" {
  type = object({
    base_image_id = map(string)
    private_network_id = string
    hosts = map(string)
  })
}
```
8. Write ```main.tf```. The essential components are a machine image, based on the created base image and the domain.
9. Create a new folder ```/infra/local/<folder>```
10. Put the following to ```main.tf``` and include the module:
```
provider "libvirt" {
  uri = "qemu:///system"
}

data "terraform_remote_state" "global" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
}
```
12. Run ```terraform apply``` in ```/infra/local```
13. Run ```terraform apply``` in ```/infra/local/<folder>```
14. Make sure everything works
