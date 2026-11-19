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
    rev = "c56b0b69dc5ef0ae3fcf5cc66a809af152dcbb4b";
    hash = "sha256-XzKjqdV0ywBMm0JJKtUYhKrep0rPy3q3HGwwWKN8MlI=";
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

