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
  typescript

  # package managers
  corepack_24
  pnpm

  # cli
  nest-cli
  awscli2

  # global node modules
  nodemon
  nodePackages_latest.ts-node

  # terminal tools
  tmux

  # security and privacy
  gnupg
  age
  sops

  # tools
  yubikey-manager
  just
  statix
]