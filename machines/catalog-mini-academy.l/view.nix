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
    rev = "600e032c75ae46bd8b6738dd22e08c3847e07242";
    hash = "sha256-CbfKQkbJdIBSuNqvBUx84m1JIltNM525cNLxo5ipLV0=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

