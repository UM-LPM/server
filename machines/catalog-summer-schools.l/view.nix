{lib, callPackage, fetchFromGitHub}:

{catalog}:
let
  mkCourses = callPackage ../../packages/make-courses.nix {};
  mkView = callPackage ../../packages/make-view.nix {};
  lock = (lib.importJSON ../../courses.json).${catalog};
in
mkView {
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "3f939d4ab7a3acd05939e15f9485f5e4bfb590d3";
    hash = "sha256-+YszHsvOKq4nS6KbbenR5+o0GtmwF7/Yo/dv+7sW6lw=";
  };
  courses = mkCourses {
    inherit catalog;
    inherit (lock) revision hash;
  };
}

