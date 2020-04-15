# Adding machines

Meta variables:
- ```{{project}}```: name of the project
- ```{{domain}}```: name of the machine
- ```{{image}}```: name of the machine image
- ```{{hostname}}```: host-name of the machine
- ```{{mac}}```: MAC address of the machine
- ```{{ip}}```: IP address of the machine

## Deploy with minimal image

### Infrastructure

1. Run ```infra/shell.sh```
2. Create a new folder ```infra/{{project}}```
3. Create a MAC address by running ```infra/mac.sh {{hostname}}```
4. Create ```infra/images/{{project}}.sh``` based on the following template and *run* it:
```
. ../lib.sh
volume-create-backing images {{image}}}.qcow2 8G minimal-base-v1.qcow2
```

5. Add the following line to ```infra/networks/private-network.xml```:
```
  <host mac="{{mac}}" name="{{hostname}}" ip="{{ip}}"/>
```

6. Create ```infra/{{project}}/{{domain}}.xml``` based on the following template:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="../domain.xsl"?>
<!DOCTYPE domain SYSTEM '../domain.dtd'>

<domain>
  <name>{{domain}}</name>
    <memory unit="G">1</memory>
    <vcpu>1</vcpu>
    <disk pool='images' volume='{{image}}.qcow2'/>
    <network-interface
        network='private-network' 
        mac='{{mac}}'/>
</domain>
```

7. Create ```infra/{{project}}/inventory.txt```, which should contain one domain per line.

8. Create the domain by running: ```domain-create {{domain}}.xml```

9. Refresh the network by running: ```infra/networks/refresh.sh```

### Configuration

1. Create a new folder ```machines/<project>```
2. Write ```machines/<project>/configuration.nix```
3. Add the following to ```ssh_config```:
```
 Host {{hostname}}
      User root
      HostName {{hostname}}
      ProxyJump bastion
```
3. Add the following to ```machines/deploy.sh``` and *run* it:
```
deploy {{hostname}} './<project>/configure.nix'
```
4. After accepting the server key commit and push the ```known_hosts``` repository


## Deploy with custom image

### Configuration

1. Create a new folder ```machines/<project>```
2. Write ```machines/<project>/configuration.nix```

3. Build the image by running (in the directory):
```
nix-build '<nixpkgs/nixos>' -A config.system.build.image -I nixos-config=configure.nix
```

### Infrastructure

1. Run ```infra/shell.sh```
2. Create a new folder ```infra/{{project}}```
3. Create a MAC address by running ```infra/mac.sh {{hostname}}```
4. Create ```infra/images/{{project}}.sh``` based on the following template and *run* it:
```
. ../lib.sh
volume-create images {{image}}-base-v1.qcow2 8G
volume-upload images {{image}}-base-v1.qcow2 '../../machines/<project>/result/nixos.qcow2'
volume-create-backing images {{image}}}.qcow2 8G {{image}}-base-v1.qcow2
```

5. Add the following line to ```infra/networks/private-network.xml```:
```
  <host mac="{{mac}}" name="{{hostname}}" ip="{{ip}}"/>
```

6. Create ```infra/{{project}}/{{domain}}.xml``` based on the following template:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="../domain.xsl"?>
<!DOCTYPE domain SYSTEM '../domain.dtd'>

<domain>
  <name>{{domain}}</name>
    <memory unit="G">1</memory>
    <vcpu>1</vcpu>
    <disk pool='images' volume='{{image}}.qcow2'/>
    <network-interface
        network='private-network' 
        mac='{{mac}}'/>
</domain>
```

7. Create ```infra/{{project}}/inventory.txt```, which should contain one domain per line.

8. Create the domain by running: ```domain-create {{domain}}.xml```

9. Refresh the network by running: ```infra/networks/refresh.sh```
