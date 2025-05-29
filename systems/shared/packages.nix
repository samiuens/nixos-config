{ pkgs, ... }:

# These packages are shared between nixos and darwin.
with pkgs; [  
  # create
  drawio

  # communication
  discord

  # development
  gitkraken
  code-cursor
  hoppscotch
  jetbrains.idea-ultimate
  jetbrains.datagrip

  # security
  keepassxc

  # frameworks
  jdk24
  nodejs_24
  typescript

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