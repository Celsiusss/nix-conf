{ lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "backlight-rs";
  version = "1.0.0";

  src = ./.;

  cargoHash = "sha256-h7qwVypayNwjS8Uvnxn0JOsWQIvm6A/YQqV4c8RpjNQ=";
}
