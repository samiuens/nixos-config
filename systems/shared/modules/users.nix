{ vars, username, hostname, pkgs, ... }: {
  users.users.${username} = {
    description = "${vars.fullName}";
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # needed, because nix doesn't detect home manager shell configuration
  };
}