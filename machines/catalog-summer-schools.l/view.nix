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
    rev = "17c74dfc0612a6bec2d077207b41a3706bf36b99";
    hash = "sha256-gtQjM7YLG90jgFqF2s29+ICdzy5IsbfuCEeId9uyx3s=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

