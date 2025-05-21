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

  # package managers
  corepack_24
  pnpm

  # cli
  nest-cli
  awscli2

  # security
  yubioath-flutter
  keepassxc
  cryptomator

  # development
  gitkraken
  code-cursor
  jetbrains.idea-ultimate
  jetbrains.datagrip

  # frameworks
  jdk24
  nodejs_24

  # tools
  just
  statix
]