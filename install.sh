#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  echo "> macos detected..."
  echo "this script will prepare system for nix-darwin installation."
  read -n 1 -s -r -p "press any key to continue or ctrl+c to abort..."

  # command line tools
  echo "installing 'command line tools'."
  xcode-select --install

  # rosetta
  echo "installing 'rosetta'."
  softwareupdate --install-rosetta --agree-to-license

  # determinate nix
  echo "installing nix..."
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm
  
  # complete
  echo "run the following command to activate the nix configuration:"
  echo "sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#"
  echo "enter the hostname corresponding to the config you want to apply."

elif [ "$(uname)" == "Linux" ]; then
  echo "> linux detected..."
fi