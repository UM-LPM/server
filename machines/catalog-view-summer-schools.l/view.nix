{lib, callPackage, fetchFromGitHub}:

{catalogId, courses, catalog}:
let
  mkCourses = callPackage ../../packages/make-courses.nix {};
  mkCatalog = callPackage ../../packages/make-catalog.nix {};
  mkView = callPackage ../../packages/make-view2.nix {};
in
mkView {
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "ac69624609d74fd22d87506dab24b90a81e67077";
    hash = lib.fakeHash;
  };
  courses = mkCourses {
    catalog = catalogId;
    inherit (courses) revision hash;
  };
  catalog = mkCatalog {
    catalog = catalogId;
    inherit (catalog) revision hash;
  };
}

