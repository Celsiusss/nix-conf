{ lib, stdenvNoCC, fetchgit }:

stdenvNoCC.mkDerivation rec {
  pname = "material-icons";
  version = "5.0.0";

  src = fetchgit {
    url = "https://github.com/google/material-design-icons.git";
    rev = "9beae745bb758f3ad56654fb377ea5cf62be4915";
    sparseCheckout = [
      "font"
    ];
    hash = "sha256-JKa5JbPQybCjUy/VyHF4qPLpwi8EhlsXzCcP4+fs9kg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    echo $PWD
    cp font/*.ttf $out/share/fonts/truetype

    runHook postInstall
  '';
}
