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
    rev = "6a43aaa3e56df6cd145a5c35de7aa8c1024d7051";
    hash = "sha256-X1+9/ShaA8+M9lRTbEaJ/pZFmjeJW4Ar4j5a7sgvtzs=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

