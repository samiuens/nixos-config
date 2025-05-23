YUBIKEY_COUNT=2

input() {
    prompt=$1
    input=""
    read -p "$prompt" input
    echo "$input"
}

###

switch()
{
  hostname=$(input "please provide the hostname: ")

  # if hostname isn't provided, then return
  if [ -z "$hostname" ]; then
    echo "please provide the ssh hostname."
    return
  fi

  # if no server configuration exists, then return
  if [ ! -d "./machines/$hostname" ]; then
    echo "no configuration found for $hostname."
    return
  fi

  nixos-rebuild --flake .#$hostname --build-host samiarda@$hostname --target-host samiarda@$hostname --use-remote-sudo --fast switch
}

provision()
{
  hostname=$(input "please provide the ssh hostname: ")

  # generate ssh keys if not found
  if [ ! -f "./secrets/public/$hostname-keychain.pub" ]; then
    echo "no key file found for $hostname."
    for i in $(seq 1 $YUBIKEY_COUNT); do
      key
    done
  fi

  # ask for configuration hostname, if not provided, then return
  if [ -z "$hostname" ]; then
    echo "please provide the ssh hostname."
    return
  fi

  # if no server configuration exists, then return
  if [ ! -d "./machines/$hostname" ]; then
    echo "no configuration found for $hostname."
    return
  fi

  # ask for ip, if not provided, then return
  ip=$(input "please provide the ssh ip: ")
  if [ -z "$ip" ]; then
    echo "please provide the ssh ip."
    return
  fi
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./server/$hostname/hardware-configuration.nix --flake .#$hostname --build-on remote --target-host root@$ip
}

key()
{
    hostname=$(input "please provide the ssh hostname: ")
    sn=$(input "please provide the yubikey serial number: ")
    keylabel=$(input "please provide the yubikey key label: ")
    ssh-keygen -t ed25519-sk -O resident -O verify-required -O application=ssh:$hostname -C "$hostname-$(date +'%d/%m/%Y')-$sn ($keylabel)" -f ./secrets/private/$hostname-$keylabel -N ""
    copy=$(input "copy the key to local machine? (y/n): ")
    mv ./secrets/private/$hostname-$keylabel.pub ./secrets/public/$hostname-$keylabel.pub
    if [ "$copy" = "y" ]; then
      cp ./secrets/private/$hostname-$keylabel ~/.ssh/$hostname-$keylabel
      cp ./secrets/public/$hostname-$keylabel.pub ~/.ssh/$hostname-$keylabel.pub
    fi
    #rm ./secrets/private/$hostname-$keylabel
    clear
}

secrets()
{
  hostname=$(input "please provide the ssh hostname: ")
  sops ./secrets/public/$hostname.yaml
}

updatekeys()
{
  hostname=$(input "please provide the ssh hostname: ")
  sops updatekeys ./secrets/public/$hostname.yaml
}

if [ $# -eq 0 ]; then
  switch
else
    case $1 in
        provision) provision ;;
        key) key ;;
        secrets) secrets ;;
        updatekeys) updatekeys ;;
        code) code . ;;
        cursor) cursor . ;;
        cd) exit ;;
        *) echo "provision, key, secrets, updatekeys" ;;
    esac
fi