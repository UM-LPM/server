{lib, stdenvNoCC, fetchFromGitHub, ruby, bundlerEnv, nodejs}:

let
  src = fetchFromGitHub {
    owner = "UM-LPM";
    repo = "short-courses";
    rev = "2574eb9e8c50c21efe51f63d65e76eb7026b5a54";
    hash = "sha256-3Eu6hJhMdqxxdH0QjT6/KZ4fBLLc317f3QY0R6Yq8Q4=";
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
    bundle exec jekyll build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
