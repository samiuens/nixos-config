{ pkgs, ... }: {
  documentation.nixos.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-maps
    gnome-frog
    gnome-notes
    gnome-music
    gnome-calendar
    gnome-calculator
    epiphany
    yelp
    snapshot
    geary
    simple-scan
  ];
}