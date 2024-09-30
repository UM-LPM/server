{lib, writeText}:
with lib;
writeText "known-hosts" ''
  ${trivial.pipe (import ./systems.nix) [
    (attrsets.mapAttrsToList (host: values:
      with values;
      if values ? port
      then "[${host}]:${toString port} ${key}"
      else "${host} ${key}"))
    (strings.concatStringsSep "\n")
  ]}
''


