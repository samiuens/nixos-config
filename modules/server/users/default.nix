{ pkgs, hostConfig, ... }: {
  imports = [ ./hm.nix ];
  
  users.users.${hostConfig.user.username} = {
    description = "${hostConfig.user.name}";
    home = "/home/${hostConfig.user.username}";
    extraGroups = [ "root" "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      ../../../secrets/public/${hostConfig.hostname}-keychain.pub
      ../../../secrets/public/${hostConfig.hostname}-backup.pub
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
    isNormalUser = true;
  };
}