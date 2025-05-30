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
    rev = "640509e5980cd384ca75ed239790dc981ca588a6";
    hash = "sha256-Jn8L9LYGMdSYfcT42iw7XRVOGh538GxnJ1pXiMiK8Ok=";
  };
  courses = mkCourses {
    inherit catalog revision hash;
  };
}

