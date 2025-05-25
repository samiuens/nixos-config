# modules/services/copy-file.nix
{ config, pkgs, lib, ... }:

{
  options.services.copyFile = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        source = lib.mkOption {
          type = lib.types.path;
          description = "Path to the source file (e.g., builtins.toFile 'name' 'content' or ./local/file.txt).";
        };

        destination = lib.mkOption {
          type = lib.types.str;
          description = "Absolute destination path for the file (including filename).";
        };

        user = lib.mkOption {
          type = lib.types.str;
          default = "root";
          description = "User to run the copy command as.";
        };

        group = lib.mkOption {
          type = lib.types.str;
          default = "root";
          description = "Group to run the copy command as.";
        };

        overwrite = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to overwrite the destination file if it already exists.";
        };

        before = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "List of systemd units that this service should run before.";
        };

        after = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "multi-user.target" ];
          description = "List of systemd units that this service should run after.";
        };
      };
    });
    description = "A service to copy files to arbitrary locations.";
  };

  config = lib.mkIf (config.services.copyFile != { }) {
    systemd.services = lib.mapAttrs' (name: cfg: {
      name = "copy-${name}-file";
      value = {
        description = "Copy file ${cfg.destination} for ${name}";
        wantedBy = cfg.after;
        before = cfg.before;
        after = cfg.after;

        serviceConfig = {
          Type = "oneshot";
          # Get the directory part of the destination path using Nix string manipulation.
          # Split the string by '/', remove the last element (the filename) using `lib.init`,
          # and then join the remaining parts back with '/'.
          # Special handling for root directory '/' case.
          ExecStartPre = let
            # Split the path into components
            pathComponents = lib.strings.splitString "/" cfg.destination;
            # Get all components except the last one (filename)
            directoryComponents = lib.init pathComponents;
            # If the path was just a filename (e.g., "file.txt"), directoryComponents would be empty.
            # In that case, the directory is "." (current directory).
            # If the path was "/file.txt", directoryComponents would be [""]. This correctly results in "/".
            targetDirectory =
              if (lib.length directoryComponents == 0) || (lib.length directoryComponents == 1 && (lib.head directoryComponents == ""))
              then "/" # Handle root directory or current directory for single filenames
              else lib.strings.concatStringsSep "/" directoryComponents;
          in "${pkgs.coreutils}/bin/mkdir -p ${targetDirectory}";

          ExecStart = "${pkgs.coreutils}/bin/cp ${lib.optionalString (!cfg.overwrite) "-n"} ${cfg.source} ${cfg.destination}";
          User = cfg.user;
          Group = cfg.group;
        };
      };
    }) config.services.copyFile;
  };
}