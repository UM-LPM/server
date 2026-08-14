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
    rev = "af0e3c08090c6fab18efbce423b1fdced32e93e7";
    hash = "sha256-0TcIDARCIdOvCrO2M7tRjegxR0dtSziR0VBtOWIAJHs=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

