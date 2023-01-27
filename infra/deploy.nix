{pkgs ? import <nixpkgs> {}}:

/*
This module generates an idempotent deployment script.
It ensures the resources described in the configuration are realized using virsh.
The resources not described in the configuration are left untouched.
That is true even if these items are named the same, becasue the UUIDs we generate will not match.

Notes:
- The UUIDs and MACs are generated based on the name of the resource.
- The creation order of the volumes is decided automatically, therefore the order described in the configuration will not be respected.
- Directly specifing XML files cannot be supported, since that would require us to parse the XML to obtain the UUID 
*/

let
  module = {lib, config, ...}:
  with lib;
  let
    inherit (trivial) pipe;

    chunk = 
    let chunk' = i: n: s:
    if i >= builtins.stringLength s
    then []
    else [(builtins.substring i n s)] ++ chunk' (i + n) n s;
    in
    chunk' 0;

    # UUID v5
    uuidOf = ns: n:
    let 
      dec16 = x:
      let f = c: {
        "0" = 0;  "1" = 1;  "2" = 2;  "3" = 3;
        "4" = 4;  "5" = 5;  "6" = 6;  "7" = 7;
        "8" = 8;  "9" = 9;  "a" = 10; "b" = 11;
        "c" = 12; "d" = 13; "e" = 14; "f" = 15;
      }."${c}";
      cs = strings.stringToCharacters x;
      u = builtins.elemAt cs 0;
      l = builtins.elemAt cs 1;
      in
      16 * f u + f l;

      enc16 = x:
      let 
        f = i: 
        if i < 10 
        then builtins.toString i
        else {
          "10" = "a";
          "11" = "b";
          "12" = "c"; 
          "13" = "d";
          "14" = "e";
          "15" = "f";
        }."${builtins.toString i}";
        u = x / 16;
        l = x - (16 * u);
      in
      f u + f l;

      addVersion = x:
      with builtins; enc16 (bitOr (bitAnd (dec16 x) 15) 80);

      addVariant = x:
      with builtins; enc16 (bitOr (bitAnd (dec16 x) 63) 128);

      bs = pipe (ns + n) [
        (builtins.hashString "sha1")
        (chunk 2)
      ];
    in 
    strings.concatStringsSep "-"
    (map concatStrings
    [
      (lists.sublist 0 4 bs)
      (lists.sublist 4 2 bs)
      [(addVersion (builtins.elemAt bs 6)) (builtins.elemAt bs 7)]
      [(addVariant (builtins.elemAt bs 8)) (builtins.elemAt bs 9)]
      (lists.sublist 10 6 bs)
    ]);

    # The values are raw bytes of the UUIDs (the raw bytes were generated first to ensure they are printable ASCII)
    namespaces = {
      pool    = "WYP5a6tNhbYhiI9Y"; # 57595035-6136-744e-6862-596869493959
      network = "5yE9CYRQeTf7W2cW"; # 35794539-4359-5251-6554-663757326357
      domain  = "sEd4ZuO5jtSwnIBT"; # 73456434-5a75-4f35-6a74-53776e494254
      #volume  = "VWwbObVQanMrgggM"; # 56577762-4f62-5651-616e-4d726767674d
    };

    macOf = name:
    # The newline needs to be added to match the behaviour of the script from:
    # https://serverfault.com/questions/299556/how-to-generate-a-random-mac-address-from-the-linux-command-line
    pipe (name + "\n") [
      (x: "02" + builtins.hashString "md5" x)
      (chunk 2)
      (lists.take 6)
      (strings.concatStringsSep ":")
    ];

    volumeOptions = {
      options.name = mkOption {
        type = types.str;
        description = "Name";
      };
      options.backing = mkOption {
        type = with types; nullOr str;
        description = "Backing volume";
        default = null;
      };
      options.capacity = mkOption {
        type = types.ints.positive;
        description = "Capacity";
      };
      options.allocation = mkOption {
        type = with types; nullOr ints.positive;
        description = "Allocation";
        default = null;
      };
    };

    poolOptions = {name, ...}: {
      options.uuid = mkOption {
        type = types.str;
        description = "UUID";
        default = uuidOf namespaces.pool name;
      };
      options.start = mkOption {
        type = types.bool;
        description = "Start pool";
        default = false;
      };
      options.autoStart = mkOption {
        type = types.bool;
        description = "Autostart pool";
        default = false;
      };
      options.path = mkOption {
        type = types.str;
        description = "Location at which the pool will be mapped into the local filesystem";
      };
      options.volumes = mkOption {
        type = with types; listOf (submodule volumeOptions);
        description = "Volumes";
      };
    };

    dhcpHostOptions = {
      options.mac = mkOption {
        type = types.str;
        description = "MAC address";
        default = macOf name;
      };
      options.hostname = mkOption {
        type = types.str;
        description = "Hostname";
      };
      options.address = mkOption {
        type = types.str;
        description = "IP address";
      };
    };

    dhcpOptions = {
      options.start = mkOption {
        type = types.str;
        description = "Start IP address";
      };
      options.end = mkOption {
        type = types.str;
        description = "End IP address";
      };
      options.hosts = mkOption {
        type = with types; listOf (submodule dhcpHostOptions);
        description = "Hosts";
        default = [];
      };
    };

    networkOptions = {name, ...}: {
      options.uuid = mkOption {
        type = types.str;
        description = "UUID";
        default = uuidOf namespaces.pool name;
      };
      options.start = mkOption {
        type = types.bool;
        description = "Start network";
        default = false;
      };
      options.autoStart = mkOption {
        type = types.bool;
        description = "Autostart network";
        default = false;
      };
      options.address = mkOption {
        type = types.str;
        description = "Gateway IP address";
      };
      options.prefixLength = mkOption {
        type = with types; addCheck int  (n: n >= 0 && n <= 32);
        description = lib.mdDoc "Subnet mask";
      };
      options.dns = mkOption {
        type = types.str;
        description = "DNS IP address";
      };
      options.bridge = mkOption {
        type = types.str;
        description = "Bridge name";
      };
      options.dhcp = mkOption {
        type = with types; nullOr (submodule dhcpOptions);
        description = lib.mdDoc "DHCP";
        default = null;
      };
    };

    domainOptions = {name, ...}: {
      options.uuid = mkOption {
        type = types.str;
        description = "UUID";
        default = uuidOf namespaces.pool name;
      };
      options.start = mkOption {
        type = types.bool;
        description = "Start domain";
        default = false;
      };
      options.autoStart = mkOption {
        type = types.bool;
        description = "Autostart domain";
        default = false;
      };
      options.memory = mkOption {
        type = types.ints.positive;
        description = "Memory in KiB";
      };
      options.vcpu = mkOption {
        type = types.ints.positive;
        description = "Number of VCPUs";
      };
      options.disks = mkOption {
        type = with types; listOf (submodule {
          options.device = mkOption {
            type = types.str;
            description = "Device";
          };
          options.pool = mkOption {
            type = types.str;
            description = "Pool";
          };
          options.volume = mkOption {
            type = types.str;
            description = "Volume";
          };
        });
        description = "Disks";
      };
      options.interfaces = mkOption {
        type = with types; listOf (submodule {
          options.network = mkOption {
            type = types.str;
            description = "Network";
          };
          options.mac = mkOption {
            type = types.str;
            description = "MAC address";
            default = macOf name;
          };
          options.hostname = mkOption {
            type = types.str;
            description = "Hostname";
          };
          options.address = mkOption {
            type = types.str;
            description = "IP address";
          };
        });
        description = "Network interfaces";
      };
    };

    sortVolumes = volumes:
    let 
      ord = lists.toposort (x: y: x.name == y.backing) volumes;
    in
    assert assertMsg (!(ord?loops || ord?cycle)) "The dependency graph of volumes needs to be acyclic!";
    ord.result;

    prefixStringLines = prefix: str:
      concatMapStringsSep "\n" (line: prefix + line) (splitString "\n" str);

    indent = prefixStringLines "  ";

    mkPoolConfig = name: uuid: x: ''
      <pool type="dir">
        <name>${name}</name>
        <uuid>${uuid}</uuid>
        <source />
        <target>
          <path>${x.path}</path>
        </target>
      </pool>
    '';

    mkInterfaceConfig = x: ''
      <interface type="network">
        <source network="${x.network}" />
        <mac address="${x.mac}" />
        <model type="virtio" />
      </interface>
    '';

    mkDiskConfig = x: ''
      <disk type="volume" device="disk">
        <driver name="qemu" type="qcow2"/>
        <source pool="${x.pool}" volume="${x.volume}" />
        <target dev="${x.device}" bus="virtio" />
      </disk>
    '';

    mkHostConfig = name: mac: ip:
    ''<host mac="${mac}" name="${name}" ip="${ip}" />'';

    mkDhcpHostConfig = x:
    ''<host mac="${x.mac}" name="${x.hostname}" ip="${x.address}" />'';

    mkDhcpConfig = x: ''
      <dhcp>
        <range start="${x.start}" end="${x.end}"/>
      ${indent (strings.concatStrings (map mkDhcpHostConfig x.hosts))}
      </dhcp>
    '';

    mkNetworkConfig = name: uuid: x: ''
      <network>
        <name>${name}</name>
        <uuid>${uuid}</uuid>
        <bridge name="${x.bridge}" />
        <forward mode="nat" />
        <dns>
            <forwarder addr="${x.dns}"/>
        </dns>
        <ip address="${x.address}" prefix="${toString x.prefixLength}">
        ${strings.optionalString (x.dhcp != null) (indent (mkDhcpConfig x.dhcp))}
        </ip>
      </network>
    '';

    #<os firmware="efi">
    #  <type arch="x86_64" machine="pc-q35-5.1">hvm</type>
    #  <firmware>
    #    <feature enabled="no" name="secure-boot"/>
    #  </firmware>
    #</os>

    mkDomainConfig = name: uuid: x: ''
      <domain type="kvm">
        <name>${name}</name>
        <memory unit="b">${toString x.memory}</memory>
        <vcpu>${toString x.vcpu}</vcpu>
        <uuid>${uuid}</uuid>
        <os>
          <type arch="x86_64">hvm</type>
        </os>
        <features>
            <acpi/>
        </features>
        <devices>
        ${indent (strings.concatStrings (map mkDiskConfig x.disks))}
        ${indent (strings.concatStrings (map (mkInterfaceConfig) x.interfaces))}
          <console type="pty"/>
          <rng model="virtio">
            <backend model="random">/dev/urandom</backend>
          </rng>
        </devices>
      </domain>
    '';

    createVolume = pool: x: ''
      if ! virsh vol-key --pool '${pool}' --vol '${x.name}'
      then
        virsh vol-create-as --pool '${pool}' --name '${x.name}' --capacity '${toString x.capacity}' ${strings.optionalString (x.allocation != null) "--allocation '${toString x.allocation}'"} --format qcow2
      fi
    '';


    writeConfig = xml: pkgs.runCommand "xml" {
      buildInputs = with pkgs; [coreutils libxml2 libuuid];
    }
    ''
      xmllint --format <(cat <<<'${xml}') > $out
    '';

    createPool = name: x:
    let 
      volumes = sortVolumes x.volumes;
      xml = writeConfig (mkPoolConfig name x.uuid x);
    in ''
      : '
      ${indent (builtins.readFile xml)}
      '
      virsh pool-define '${xml}'
      virsh pool-build ${x.uuid}
      ${if x.start then "virsh pool-start ${x.uuid}" else "virsh pool-destroy ${x.uuid}"}
      ${if x.autoStart then "virsh pool-autostart ${x.uuid}" else "virsh pool-autostart ${x.uuid} --disable" }

      ${strings.concatStrings (map (createVolume name) volumes)}
    '';

    createNetwork = name: x:
    let
      xml = writeConfig (mkNetworkConfig name x.uuid x);
    in ''
      : '
      ${indent (builtins.readFile xml)}
      '
      virsh net-define '${xml}'
      ${strings.optionalString x.start "virsh net-start ${x.uuid}"}
      ${strings.optionalString x.autoStart "virsh net-autostart ${x.uuid}"}
    '';

    updateHost = x: ''
      virsh net-update '${x.network}' add ip-dhcp-host '${mkHostConfig x.hostname x.mac x.address}' --live
    '';

    createDomain = name: x:
    let
      xml = writeConfig (mkDomainConfig name x.uuid x);
    in ''
      : '
      ${indent (builtins.readFile xml)}
      '
      virsh define '${xml}'
      ${if x.start then "virsh start ${x.uuid}" else "virsh shutdown ${x.uuid}"}
      ${if x.autoStart then "virsh autostart ${x.uuid}" else "virsh autostart ${x.uuid} --disable"}

      ${strings.concatStrings (map updateHost x.interfaces)}
    '';

    deploymentScript = pkgs.writeShellScript "builder.sh" ''
      ${strings.concatStrings (attrsets.mapAttrsToList createPool config.pools)}
      ${strings.concatStrings (attrsets.mapAttrsToList createNetwork config.networks)}
      ${strings.concatStrings (attrsets.mapAttrsToList createDomain config.domains)}
    '';
  in
  {
    options._module.args = mkOption {
      type = types.lazyAttrsOf types.raw;
    };

    options.toplevel = mkOption {
      type = lib.types.package;
    };

    options.pools = mkOption {
      description = "Pools";
      type = with types; attrsOf (submodule poolOptions);
    };

    options.networks = mkOption {
      description = "Networks";
      type = with types; attrsOf (submodule networkOptions);
    };

    options.domains = mkOption {
      description = "Domains";
      type = with types; attrsOf (submodule domainOptions);
    };

    config._module.args = {
      inherit macOf;
      unit = {
        kB = x: 1000 * x;
        MB = x: 1000000 * x;
        GB = x: 1000000000 * x;
        kiB = x: 1024 * x;
        MiB = x: 1048576 * x;
        GiB = x: 1073741824 * x;
      };
    };

    config.networks = pipe config.domains [
      (attrsets.mapAttrsToList (_: x: x.interfaces))
      lists.flatten
      (builtins.groupBy (i: i.network))
      (builtins.mapAttrs (_: is: {
        dhcp.hosts = map (i: {inherit (i) mac hostname address;}) is;
      }))
    ];

    config.toplevel =
      debug.traceSeq (null) (
      pkgs.linkFarm "virsh-scripts" {
        deploy = deploymentScript;
      });
  };
in
(import <nixpkgs/lib>).evalModules {
  modules = [module <infra>];
}
