{ pkgs ? import <nixpkgs> }:

{
  material-icons = pkgs.callPackage ./material-icons {};
  omz-custom = pkgs.callPackage ./omz-custom {};
}
