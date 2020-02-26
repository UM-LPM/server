# Adding machines

0. Select name of the project machine taged in instruction as ```<project>``` for example see test
1. Create a new folder ```/machines/<project>```
2. Write ```configuration.nix```
3. Build the image by running:
```
nix-build '<nixpkgs/nixos>' -A config.system.build.image -I nixos-config=configure.nix
```

4. Add the path to the base image to ```image_paths``` in ```/infra/modules/images/main.tf```
5. Add the hostname and ip to ```hosts``` in ```/infra/modules/network/variables.tf```

6. Create a new folder ```/infra/modules/<project>```
7. Create ```variables.tf``` with following content:
```HCL
variable "global" {
  type = object({
    base_image_id = map(string)
    private_network_id = string
    hosts = map(string)
  })
}
```
8. Write ```main.tf```. The essential components are a machine image, based on the created base image and the domain.
9. Create a new folder ```/infra/local/<project>```
10. Create ```main.tf``` with following content:
```HCL
provider "libvirt" {
  uri = "qemu:///system"
}

data "terraform_remote_state" "global" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
  
  module "<project>" {
    source = "../../modules/<project>"
    global = data.terraform_remote_state.global.outputs.global
  }
}
```
12. Run ```terraform apply``` in ```/infra/local```
13. Run ```terraform apply``` in ```/infra/local/<folder>```
14. Make sure everything works
15. Create a new folder ```/infra/prod/<project>```
16. Create ```main.tf``` with following content:
```HCL
provider "libvirt" {
  uri = "qemu+ssh://user@lpm-server.feri.um.si:12022/system"
}

data "terraform_remote_state" "global" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
  
  module "<project>" {
    source = "../../modules/<project>"
    global = data.terraform_remote_state.global.outputs.global
  }
}
```
17. Get the recent ```terraform.tfstate``` files //currently at Žiga computer (push and ask Žiga for next step)
18. Run ```terraform apply``` in ```/infra/prod```
19. Run ```terraform apply``` in ```/infra/prod/<folder>```
