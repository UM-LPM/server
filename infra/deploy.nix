{pkgs ? import <nixpkgs> {}}:

pkgs.writeShellScript "builder.sh" ''
  echo "HELLO"
''
