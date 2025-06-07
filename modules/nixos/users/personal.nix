{ pkgs, hostConfig, ... }: {
  users.users.${hostConfig.user.username} = {
    description = "${hostConfig.user.name}";
    home = "/home/${hostConfig.user.username}";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
    isNormalUser = true;
  };
}