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
    rev = "ae1aeb2b71f27ae035384855d2b100011e24eae4";
    hash = "sha256-Uc/U2iwXVu+HtUt4zRT7TPD6MoJLQPVCl2gv9R0mrlk=";
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

