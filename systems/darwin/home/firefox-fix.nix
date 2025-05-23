{ config, ... }: {
  home.activation.firefoxProfile = lib.hm.dag.entryAfter [ "writeBoundry" ] ''
    run mv ${config.home.homeDirectory}/Library/Application\ Support/Firefox/profiles.ini ${config.home.homeDirectory}/Library/Application\ Support/Firefox/profiles.hm
    run cp ${config.home.homeDirectory}/Library/Application\ Support/Firefox/profiles.hm ${config.home.homeDirectory}/Library/Application\ Support/Firefox/profiles.ini
    run rm -f ${config.home.homeDirectory}/Library/Application\ Support/Firefox/profiles.ini.bak
    run chmod u+w ${config.home.homeDirectory}/Library/Application\ Support/Firefox/profiles.ini
  '';
}