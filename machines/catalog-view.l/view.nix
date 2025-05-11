{lib, stdenvNoCC, fetchurl, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

let
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "44cd1bf44a1bd6e5f2ea0f24184910b2f338ba95";
    hash = "sha256-Y6X94w7QaXWSooL7cYOnfsYprTYS2Zyhe38dzdue1FM=";
  };
  courses = fetchurl {
    url = "http://catalog-manage.l:8080/api/course/short-courses/3b88bf36-eb8b-4c9f-bd29-545451665e87?timestamp=2025-05-11T07:10:00Z";
    hash = "sha256-pO6BJsHVgue6mDtQNgTXIeHMGMTSTzRvnUOaoHc4N3c=";
  };
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
