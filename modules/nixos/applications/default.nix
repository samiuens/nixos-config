{ config, pkgs, lib, ... }:

let
  loadHostConfigApplications = hostConfig:
    let
      appModulePaths = lib.filter
        (path:
          let
            baseName = builtins.baseNameOf path;
          in
          lib.hasSuffix ".nix" baseName
        )
        (builtins.map (name: "./${name}") (builtins.attrNames (builtins.readDir currentDir)));

      activeAppImports = lib.filter (appModule: appModule != { }) (
        lib.map (appPath:
          let
            appName = lib.removeSuffix ".nix" (builtins.baseNameOf appPath);
          in
          if lib.getAttrFromPath [ appName ] hostConfig.applications or false
          then appPath
          else { }
        ) appModulePaths
      );
    in
    activeAppImports;
in
{
  imports = [
    (loadHostConfigApplications hostConfig.applications)
  ];
}