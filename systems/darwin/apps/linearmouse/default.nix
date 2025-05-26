{ config, ... }: {
  home.file.".config/linearmouse/linearmouse.json" = {
    source = ./linearmouse.json;
    recursive = true;
  };
}