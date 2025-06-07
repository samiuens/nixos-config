{ pkgs }:

with pkgs;
let shared-packages = import ./shared.nix { inherit pkgs; }; in
shared-packages ++ [
  # create
  obsidian
  anki

  # communication
  vesktop

  # hosting
  termius
  trayscale

  # security
  yubioath-flutter
  cryptomator

  # tweaks
  dconf-editor
]