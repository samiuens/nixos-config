{ config, ...}:
  let
    gpgConfigFile = builtins.readFile ./gpg.conf; in
  {
    programs.gnupg = {
      enable = true;
      settings = gpgConfigFile;
    };
  }