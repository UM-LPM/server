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
    rev = "22406f11bdf3cb8a55ab25c71145809164c42384";
    hash = "sha256-2qviaLKHeP9U1hAkdGYSxqXtCZ9h5u9O5plxerWop9U=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

