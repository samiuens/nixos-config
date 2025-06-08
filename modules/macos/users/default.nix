{ pkgs, hostConfig, ... }: {
  imports = [ ./hm.nix ];
  
  users.users.${hostConfig.user.username} = {
    description = "${hostConfig.user.name}";
    home = "/Users/${hostConfig.user.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
    isHidden = false;
  };
  system.primaryUser = "${hostConfig.user.username}";
}