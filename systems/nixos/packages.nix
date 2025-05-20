{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # consume
  firefox

  # create
  obsidian
  anki
  drawio


  # communication
  discord

  # development
  gitkraken
  code-cursor
  jetbrains.idea-ultimate
  jetbrains.datagrip

  # hosting
  termius

  # security
  yubioath-flutter
  keepassxc
  cryptomator

  # tweaks
  dconf-editor
]