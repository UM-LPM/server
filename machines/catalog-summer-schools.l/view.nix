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
    rev = "c4cbbde4d0aa5db03b84ddc36cfa5996137e1324";
    hash = "sha256-svRsQ+CiIWOJj0OVNG8+8uL/cWtQkWukcD511Cixn9E=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

