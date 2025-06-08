{ config, ... }:
  let 
    bmw_config = "burn-my-windows/profiles/default.conf"; 
  in {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = ["blur-my-shell@aunetx" "burn-my-windows@schneegans.github.com" "pano@elhan.io"];
      };
      "org/gnome/desktop/interface" = {
        clock-show-seconds = true;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        #accent-color = "blue";
      };
      # Extension settings
      "org/gnome/shell/extensions/burn-my-windows" = {
        active-profile = "${config.xdg.configHome}/${bmw_config}";
      };
      "org/gnome/shell/extensions/pano" = {
        history-length = 100;
        play-audio-on-copy = false;
        send-notification-on-copy = false;
        exclusion-list = ["Bitwarden" "1Password" "KeePassXC" ];
      };
    };
  };

  # Import settings file for 'burn-my-windows'
  home.file."${config.xdg.configHome}/${bmw_config}" = {
    source = ./burn-my-windows.conf;
    recursive = true;
  };
}