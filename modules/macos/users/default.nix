{ pkgs, lib, hostConfig, ... }: {
  imports = [ ./hm.nix ];
  
  users.users.${hostConfig.user.username} = {
    description = "${hostConfig.user.name}";
    home = "/Users/${hostConfig.user.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
    isHidden = false;
  };

  users.users.${hostConfig.workUser.username} = lib.mkIf hostConfig.workUser.enabled {
    description = "${hostConfig.workUser.name}";
    home = "/Users/${hostConfig.workUser.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
    isHidden = false;
  };

  system.primaryUser = "${hostConfig.user.username}";
}