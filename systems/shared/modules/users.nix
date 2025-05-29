{ vars, username, hostname, pkgs, work, lib, ... }: {
  users.users.${username} = {
    description = "${vars.fullName}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # needed, because nix doesn't detect home manager shell configuration
  };

  users.users.${vars.work.username} = lib.mkIf work {
    description = "${vars.work.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}