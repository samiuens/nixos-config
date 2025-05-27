{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # storage
  syncthing
  
  # utils
  aerospace
  aldente
  betterdisplay
]