{
  # Zsh shell
  programs.zsh = {
    enable = true;
    enableCompletions = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      config = "cd ~/nixos-config && just $1";
    };
    history.size = 10000;

    # Extending with oh-my-zsh and plugins
    zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
    };
  };

  # Oh-my-posh for style
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "bubblesline";
  };
}