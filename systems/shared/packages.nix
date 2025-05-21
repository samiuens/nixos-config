{ pkgs, ... }:

# These packages are shared between nixos and darwin.
with pkgs; [
  # frameworks
  jdk24
  nodejs_24

  # tools
  just
  statix
]