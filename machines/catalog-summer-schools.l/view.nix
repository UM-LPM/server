{lib, callPackage, fetchFromGitHub}:

{catalog, revision, hash}:
let
  mkCourses = callPackage ../../packages/make-courses.nix {};
  mkView = callPackage ../../packages/make-view.nix {};
  lock = (lib.importJSON ../../courses.json).${catalog};
in
mkView {
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "af18c46afe39e93310cdc2f3e163aaf818ad3c33";
    hash = "sha256-Epm2C6V1xchD1gsix1nQcV6/jKbn4JzUn49buX/xAP0=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

