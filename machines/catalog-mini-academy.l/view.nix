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
    rev = "a3be02404e2fd1aa994a0ea7979e7d7574ca48c5";
    hash = "sha256-jQUm3z+drWwrllAY96NUO8bnsnfxcTLC5kdMJWBeZ10=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

