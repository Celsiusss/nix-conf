{ stdenv }:

stdenv.mkDerivation {
  pname = "omz-custom";
  version = "1.0";
  src = ./.;
  phases = ["installPhase"];
  installPhase = ''
    install -Dm044 $src/themes/gianu-custom.zsh-theme $out/themes/gianu-custom.zsh-theme
  '';
}
