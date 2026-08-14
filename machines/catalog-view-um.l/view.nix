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
    rev = "6530a1c824ffd92dc36220c8425624ba2e1b704b";
    hash = "sha256-1i7UfnvdKVjZVaE++hz0/v4Q0kbWQjPD9U5K5jTjU4Q=";
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

