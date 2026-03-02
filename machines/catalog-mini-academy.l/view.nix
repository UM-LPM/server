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
    rev = "c4d8f4213970dec58418695907e400daae492341";
    hash = "sha256-SWVNdlr+aQhT8pc+WZp3yElqxPIrknRAJgaOsp3yBF0=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

