{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # productivity
  firefox

  # development
  gitkraken
  code-cursor
  
  # tweaks
  dconf-editor
]