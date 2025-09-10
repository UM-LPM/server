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
    rev = "076ecdca90f025a301ab03f33c8eb29c2cae2898";
    hash = "sha256-JTDjjbQM0tJV/qxUyeGRp1TCVe9rOsS/+LXtnF2NSVI=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

