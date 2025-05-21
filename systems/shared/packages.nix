{ pkgs, ... }:

# These packages are shared between nixos and darwin.
with pkgs; [
  # create
  obsidian
  anki
  drawio

  # communication
  discord

  # hosting
  termius

  # development
  gitkraken
  code-cursor
  requestly
  jetbrains.idea-ultimate
  jetbrains.datagrip

  # security
  yubioath-flutter
  keepassxc
  cryptomator

  # frameworks
  jdk24
  nodejs_24

  # package managers
  corepack_24
  pnpm

  # cli
  nest-cli
  awscli2

  # tools
  just
  statix
]