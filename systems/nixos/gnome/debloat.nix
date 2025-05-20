{ pkgs, ... }: {
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-maps
    gnome-frog
    gnome-notes
    gnome-music
    gnome-calendar
    epiphany
    yelp
    snapshot
  ];
}