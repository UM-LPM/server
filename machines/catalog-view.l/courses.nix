{lib, callPackage}:
let
  mkCourses = callPackage ../../packages/make-courses.nix {};
in
mkCourses {
  catalog = "3b88bf36-eb8b-4c9f-bd29-545451665e87";
  revision = builtins.readFile ./revision;
  hash = "sha256-stBcMVbk+HcPp6jMPa7L6JkIIxRrEnfP6r2rPOQwMag=";
}
