{
  # Zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    shellAliases = {
      config = "cd ~/nixos-config && just $1";
    };

    # Extending with oh-my-zsh and plugins
    oh-my-zsh = {
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