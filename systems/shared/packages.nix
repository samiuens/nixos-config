{ pkgs, ... }: 
with pkgs; [
  # frameworks
  jdk24
  nodejs_24

  # tools
  just
  statix
]