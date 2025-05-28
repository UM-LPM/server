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
    rev = "c2b70a72cbd379a05d2c3bb1ba99187d36c1ce82";
    hash = "sha256-9qFi9lCn/Y1e6r03sq+yHZFuHN1o1vev4r0GLQ3L7sc=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

