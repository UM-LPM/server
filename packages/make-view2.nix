{lib, stdenvNoCC, callPackage, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

{
  src,
  courses,
  catalog
}:
let
  jekyll_env = bundlerEnv {
    name = "jekyll_env";
    inherit ruby;
    gemdir = src;
  };
in
stdenvNoCC.mkDerivation {
  pname = "view";
  version = "1.0.0";
  inherit src;
  inherit courses;

  buildInputs = [
    jekyll_env
    nodejs
  ];

  buildPhase = ''
    cp ${courses} _data/courses.json
    cp ${catalog} _data/catalog.json
    bundle exec jekyll build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
