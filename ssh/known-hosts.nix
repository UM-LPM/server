{lib, writeText}:
with lib;
writeText "known-hosts" ''
  ${trivial.pipe (import ./systems.nix) [
    (attrsets.mapAttrsToList (host: key: "${host} ${key}"))
    (strings.concatStringsSep "\n")
  ]}
''


