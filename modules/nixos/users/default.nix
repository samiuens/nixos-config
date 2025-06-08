{ pkgs, lib, hostConfig, ... }: {
  imports = [ ./hm.nix ];
  
  users.users.${hostConfig.user.username} = {
    description = "${hostConfig.user.name}";
    home = "/home/${hostConfig.user.username}";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
    isNormalUser = true;
  };

  users.users.${hostConfig.workUser.username} = lib.mkIf hostConfig.workUser.enabled {
    description = "${hostConfig.workUser.name}";
    home = "/home/${hostConfig.workUser.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    isNormalUser = true;
  };
}