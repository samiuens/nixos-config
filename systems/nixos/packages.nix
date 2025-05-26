{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # create
  obsidian

  # hosting
  termius

  # security
  yubioath-flutter
  cryptomator

  # tweaks
  dconf-editor
  desktop-file-utils
]