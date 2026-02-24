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
    rev = "3446ee5efae475fbadb295209d89c8da609e2d89";
    hash = "sha256-UZXSB15+JhHH4E7MIhTFuY7YmipSk2C2lHBs/QIJHww=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

