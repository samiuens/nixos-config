{ pkgs }:

with pkgs;
let shared-packages = import ./shared.nix { inherit pkgs; }; in
shared-packages ++ [
  # communication
  discord
  
  # utils
  aerospace
  aldente
  betterdisplay
]