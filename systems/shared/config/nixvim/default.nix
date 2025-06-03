let
  plugins = [
    "telescope"
  ];
in
{
  imports = [] ++ builtins.map (pluginName: ./plugins/${pluginName}) plugins;
  programs.nixvim = {
    enable = true;
  };
}