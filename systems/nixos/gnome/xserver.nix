{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.xserver.excludePackages = with pkgs; [ xterm ];
}