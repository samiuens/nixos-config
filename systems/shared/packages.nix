{ pkgs, ... }: 
with pkgs; [
  # frameworks
  jdk24
  nodejs_24
  typescript

  # global node modules
  nodemon
  nodePackages_latest.ts-node1

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