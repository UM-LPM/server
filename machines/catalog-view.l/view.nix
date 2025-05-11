{lib, stdenvNoCC, callPackage, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

let

  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "44cd1bf44a1bd6e5f2ea0f24184910b2f338ba95";
    hash = "sha256-Y6X94w7QaXWSooL7cYOnfsYprTYS2Zyhe38dzdue1FM=";
  };

  courses = callPackage ./courses.nix {};

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
