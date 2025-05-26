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
    rev = "1269474a57f13369dde02dfa421ef3f74e8d541a";
    hash = "sha256-qud7M7rstZW6apWStIzyVYzWeqKfYNpQrBTVNXylSRo=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

