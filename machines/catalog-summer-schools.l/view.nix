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
    rev = "1080412b9098bbb0aa85c1dfb0acb8b42b979080";
    hash = lib.fakeHash;
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

