{lib, callPackage, fetchFromGitHub}:

let
  courses = callPackage ./courses.nix {};

  mkView = callPackage ../../packages/make-view.nix {};
in
mkView {
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "3f939d4ab7a3acd05939e15f9485f5e4bfb590d3";
    hash = "sha256-+YszHsvOKq4nS6KbbenR5+o0GtmwF7/Yo/dv+7sW6lw=";
  };
  inherit courses;
}

