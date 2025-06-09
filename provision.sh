input() {
  prompt=$1
  input=""
  read -p "$prompt" input
  echo "$input"
}

provision()
{
  hostname=$(input "> please provide the ssh hostname: ")

  echo "> looking for ssh keys (in secrets/public)..."
  if ! compgen -G "./secrets/public/${hostname}*" > /dev/null; then
    echo "no key files found for $hostname."
  fi

  if [ -z "$hostname" ]; then
    echo "please provide the ssh hostname."
    exit 1
  fi

  echo "> reading nix configuration..."
  if [ ! -d "./hosts/$hostname" ]; then
    echo "no configuration found for $hostname."
    exit 1
  fi

  ip=$(input "> please provide the ssh ip: ")
  if [ -z "$ip" ]; then
    echo "invalid host ip."
    exit 1
  fi

  echo "> generating hardware config and installing nixos with the provided config, on the remote host..."
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./server/$hostname/hardware-configuration.nix --flake .#$hostname --build-on remote --target-host root@$ip
}