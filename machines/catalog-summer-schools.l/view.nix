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
    rev = "77b7377f2a21ded4956f34b48ca53e4182f9fc21";
    hash = "sha256-KoGDqGVu1nIo4O1va7cnabtvcYBv7DrenYwWZvF7XOc=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

