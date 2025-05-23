{lib, stdenvNoCC, callPackage, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

{
  src,
  courses
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

  buildInputs = [
    jekyll_env
    nodejs
    courses
  ];

  buildPhase = ''
    cp ${courses} _data/courses.json
    bundle exec jekyll build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
