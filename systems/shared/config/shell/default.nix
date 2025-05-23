{
  # Zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    autocd = true;
    initExtra = ''
      GPG_TTY=$(tty)
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
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./theme.json));
  };

  # Eza for better ls command
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    colors = "auto";
  };
}