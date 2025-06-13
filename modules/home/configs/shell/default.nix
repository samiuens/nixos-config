{
  programs = {
    # Zsh shell
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      autocd = true;
      initContent = ''
        export GPG_TTY=$(tty)
      '';

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
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./theme.json));
    };

    # Eza for better ls command
    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      colors = "auto";
    };
  };
}