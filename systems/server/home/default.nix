{ username, pkgs, ... }: {
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };
}
