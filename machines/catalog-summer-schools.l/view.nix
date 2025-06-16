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
    rev = "ad6955b7da04caaa00528936297b4529e348dd5c";
    hash = "sha256-zcCLnTGRfcouFv/E1KTlmp18fI/3vfsJgmnk8PMZqcM=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

