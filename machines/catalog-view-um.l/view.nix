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
    rev = "213e3234d61828b6b299c2fd0c22e6993983cc7f";
    hash = "sha256-r+m5hsh0XARfhDV6E9GySGVdGt/OXZ6akmUkT6zNLu4=";
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

