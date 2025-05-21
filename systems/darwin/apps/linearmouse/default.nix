{ config, ... }: {
  home.file.".config/linearmouse/linearmouse.json" = {
    source = ../../../configs/linearmouse/linearmouse.json;
    recursive = true;
  };
}