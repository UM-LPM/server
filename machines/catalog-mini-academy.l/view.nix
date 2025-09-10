{lib, callPackage, fetchFromGitHub}:

{catalog, revision, hash}:
let
  mkCourses = callPackage ../../packages/make-courses.nix {};
  mkView = callPackage ../../packages/make-view.nix {};
in
mkView {
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "484f8faebf0da73cbdd1d8aa885c54258b24874b";
    hash = "sha256-vnuD52uVu550J0Y/UDJRsigm6TFjClr8EFIrDyIn5e0=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

