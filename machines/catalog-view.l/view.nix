{lib, stdenvNoCC, fetchurl, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

let
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "6a6a82e5baedce00f030cbb7f6a6d89afa6be57f";
    hash = "sha256-Gg6J5Go4mE/iNUc2Uyd2fu19cob/eYvhRARDVl9Xhp0=";
  };
  courses = fetchurl {
    url = "https://catalog.pmd.lpm.feri.um.si/api/course";
    hash = "sha256-p+THcJJl5qAtltQUOb2FULZpkxXwIb3QM5KoeWrywVc=";
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
