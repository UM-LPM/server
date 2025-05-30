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
    rev = "2540d191a119c566da729ee35f9f27a30c4ea89a";
    hash = "sha256-SHPE1ho/GHPtkvfETmxu5ynZ+KHIqU4Q1AKXTJ39Nlg=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

