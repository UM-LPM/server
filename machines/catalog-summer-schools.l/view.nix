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
    rev = "44cd1bf44a1bd6e5f2ea0f24184910b2f338ba95";
    hash = "sha256-Y6X94w7QaXWSooL7cYOnfsYprTYS2Zyhe38dzdue1FM=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

