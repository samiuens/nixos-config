{ pkgs, ... }:

# These packages are shared between nixos and darwin.
with pkgs; [
  # coordination
  todoist
  
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

  # cli
  nest-cli
  awscli2

  # package managers (node-specific)
  corepack_24
  pnpm

  # global node modules
  nodemon
  nodePackages_latest.ts-node

  # security and privacy
  age
  sops

  # tools
  yubikey-manager
  just
  statix
  tmux
]