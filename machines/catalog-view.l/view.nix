{lib, stdenvNoCC, callPackage, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

let

  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "3f939d4ab7a3acd05939e15f9485f5e4bfb590d3";
    hash = "sha256-+YszHsvOKq4nS6KbbenR5+o0GtmwF7/Yo/dv+7sW6lw=";
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
