{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # create
  obsidian
  anki

  # communication
  vencord

  # hosting
  termius
  trayscale

  # security
  yubioath-flutter
  cryptomator

  # tweaks
  dconf-editor
  desktop-file-utils
]