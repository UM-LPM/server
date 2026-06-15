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
    rev = "ac69624609d74fd22d87506dab24b90a81e67077";
    hash = lib.fakeHash;
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

