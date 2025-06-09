#!/usr/bin/env bash

input() {
  prompt=$1
  input=""
  read -p "$prompt" input
  echo "$input"
}

if [ "$(uname)" == "Darwin" ]; then
  echo "> macos detected..."
  echo "this script will prepare the system for nix-darwin installation."
  read -n 1 -s -r -p "press any key to continue or ctrl+c to abort..."
  echo ""
  
  # command line tools
  echo "installing 'command line tools'."
  if [[ -e /Library/Developer/CommandLineTools/usr/bin/git ]]; then
    echo "'command line tools' already installed."
  else
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    softwareupdate -i "$PROD" --verbose
    echo "successfully installed 'command line tools'".
  fi

  # rosetta
  echo "installing 'rosetta'."
  softwareupdate --install-rosetta --agree-to-license
  echo "successfully installed 'rosetta'".

  # determinate nix
  echo "installing nix..."
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm
  
  # complete
  echo "shell restart is needed."
  echo "after that, run the following command to activate the nix configuration:"
  echo "sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#"
  echo "enter the hostname corresponding to the config you want to apply."

elif [ "$(uname)" == "Linux" ]; then
  echo "> linux detected..."
  echo ""

  echo "> setting up folder structure..."
  git clone https://github.com/samiuens/nixos-config.git ~/nixos-config
  cd ~/nixos-config
  echo "cloned repo into home directory (under ~/nixos-conig)"

  hostname=$(input "> please provide the hostname, corresponding to the config you want to apply: ")

  echo "> reading nix configuration..."
  if [ ! -d "./hosts/$hostname" ]; then
    echo "no configuration found for $hostname in this repo."
    exit 1
  fi
  echo "read nix configuration."

  echo "> generating hardware config..."
  sudo rm -r ./hosts/$hostname/hardware-configuration.nix
  sudo nixos-generate-config --dir ./hosts/$hostname
  echo "generated hardware configuration and copied into repo."

  echo "> generating secure boot keys..."
  sudo nix-shell -p sbctl --command "sbctl create-keys" 
  echo ""
  echo "generated secure boot keys."
  
  sudo nixos-rebuild switch --flake ".#$hostname"
fi