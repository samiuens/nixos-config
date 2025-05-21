{ config, ... }: {
  home.file."${config.xdg.configHome}/aerospace/aerospace.toml" = {
    source = ./aerospace.toml;
  };
}