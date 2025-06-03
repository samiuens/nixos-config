{ pkgs, ... }: {
  imports = [ ./plugins ];
  home.packages = with pkgs; [
    ripgrep
    fd
  ];
  programs.nixvim = {
    enable = true;   
  }; 
}