# Deploy changes for local machine
default:
  #!/usr/bin/env sh
  if [ "$OSTYPE" == "macos"* ]; then
    sudo darwin-rebuild switch --flake ".#"
  else
    sudo nixos-rebuild switch --fast --flake ".#"
  fi

# Deploy changes for remote host
deploy host:
  nixos-rebuild switch --fast --flake ".#{{host}}" --use-remote-sudo --target-host "samiarda@{{host}}" --build-host "samiarda@{{host}}"

# Update nix flakes
up:
  nix flake update

# Run nix garbage collector
gc:
  sudo nix-collect-garbage -d && nix-collect-garbage -d

# Edit sops secrets for host
secrets host:
  sops ./secrets/public/{{host}}.yaml

# Update keys for sops secret
updatekeys:
  for file in secrets/public/*.yaml; do sops updatekeys "$file"; done

# Switch to directory
cd:
  cd .

# Open config in vscode
code:
  code .

# Open config in cursor
cursor:
  cursor .

# Lint check for this config
lint:
  statix check

# Fix lint issues for this config
lint-fix:
  statix fix

# Get help
help:
  just --list