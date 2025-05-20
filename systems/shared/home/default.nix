{ username, system, pkgs, ... }: {
  imports = [ ../../${system}/home ];
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
