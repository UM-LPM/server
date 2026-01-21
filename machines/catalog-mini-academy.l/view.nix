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
    rev = "bbac839ea1e3d6028048f004a9f65235bb1737f5";
    hash = "sha256-aKMH0S/Q+ymkDpSHEzJ2cn4BclAtWx7tZpkhtK5FGsE=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

