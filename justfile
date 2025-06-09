# Deploy changes for local machine
default method='switch':
  #!/usr/bin/env sh
  if [ "$(uname)" == "Darwin" ]; then
    sudo darwin-rebuild {{method}} --flake ".#"
  else
    sudo nixos-rebuild {{method}} --flake ".#"
  fi

# Deploy changes for remote host
deploy host method='switch':
  nixos-rebuild {{method}} --fast --flake ".#{{host}}" --use-remote-sudo --build-host "samiarda@{{host}}" --target-host "samiarda@{{host}}" 

# Update nix flakes
up:
  nix flake update

# Run nix garbage collector
gc:
  sudo nix-collect-garbage -d && nix-collect-garbage -d

# Edit sops secrets for host
secrets host:
  sops ./secrets/creds/{{host}}.yaml

# Update keys for sops secret
updatekeys:
  for file in secrets/creds/*.yaml; do sops updatekeys "$file"; done

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

# Generate a pair of ssh keys on plugged-in yubikey
sshkey hostname sn keylabel copy='n':
  #!/usr/bin/env sh
  mkdir -p ./secrets/private
  ssh-keygen -t ed25519-sk -O resident -O verify-required -O application=ssh:"{{hostname}}" -C "{{hostname}}-$(date +'%d/%m/%Y')-{{sn}} ({{keylabel}})" -f ./secrets/private/"{{hostname}}_{{keylabel}}" -N ""
  mv ./secrets/private/"{{hostname}}_{{keylabel}}".pub ./secrets/public/"{{hostname}}_{{keylabel}}".pub
  if [ "{{copy}}" = "y" ]; then
    cp ./secrets/private/"{{hostname}}_{{keylabel}}" ~/.ssh/"{{hostname}}_{{keylabel}}"
    cp ./secrets/public/"{{hostname}}_{{keylabel}}".pub ~/.ssh/"{{hostname}}_{{keylabel}}".pub
  fi  
#rm ./secrets/private/"{{hostname}}_{{keylabel}}"

# Get help
help:
  just --list
