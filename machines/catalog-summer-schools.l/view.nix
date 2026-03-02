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
    rev = "fb06305839f24c2acb761b6ba2bde92629ce8a19";
    hash = "sha256-GKqEAL8v8i8BGw0gUBesfyh9TinXdmhp1utYeI/ITkM=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

