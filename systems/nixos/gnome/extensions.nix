{ pkgs, ...}: {
  environment.systemPackages = with pkgs.gnomeExtensions; 
    [
      blur-my-shell
      burn-my-windows
      pano
    ];
}