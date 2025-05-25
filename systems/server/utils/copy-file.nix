{ config, pkgs, lib, ... }: # `lib` for utility functions like `mkIf`

# Define a function that generates a Systemd service to copy a file.
# This function accepts an attribute set as arguments.
{
  options.services.copyFile = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        # The absolute path to the source file in the Nix store or as a local path (which will then be copied to the store)
        source = lib.mkOption {
          type = lib.types.path;
          description = "Path to the source file (e.g., builtins.toFile 'name' 'content' or ./local/file.txt).";
        };

        # The absolute destination path of the file on the system
        destination = lib.mkOption {
          type = lib.types.str; # String, as it's a path in the Linux filesystem
          description = "Absolute destination path for the file (including filename).";
        };

        # Optional: User under which the copy operation should be executed
        user = lib.mkOption {
          type = lib.types.str;
          default = "root";
          description = "User to run the copy command as.";
        };

        # Optional: Group under which the copy operation should be executed
        group = lib.mkOption {
          type = lib.types.str;
          default = "root";
          description = "Group to run the copy command as.";
        };

        # Optional: Whether the file should be overwritten if it exists (defaults to not overwriting)
        overwrite = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to overwrite the destination file if it already exists.";
        };

        # Optional: Dependencies this service should run before
        before = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "List of systemd units that this service should run before.";
        };

        # Optional: Dependencies this service should run after
        after = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "multi-user.target" ]; # Defaults to running after multi-user.target
          description = "List of systemd units that this service should run after.";
        };
      };
    });
    description = "A service to copy files to arbitrary locations.";
  };

  config = lib.mkIf (config.services.copyFile != { }) {
    # Iterate over all instances defined under services.copyFile
    systemd.services = lib.mapAttrs' (name: cfg: {
      name = "copy-${name}-file"; # Unique name for the service
      value = {
        description = "Copy file ${cfg.destination} for ${name}";
        wantedBy = cfg.after; # Use 'after' for wantedBy, as it's more logical
        before = cfg.before;
        after = cfg.after; # Run the service after these targets/services

        serviceConfig = {
          Type = "oneshot";
          # Determine the copy option: '-n' for no-clobber, empty for overwrite
          ExecStart = "${pkgs.coreutils.cp}/bin/cp ${lib.optionalString (!cfg.overwrite) "-n"} ${cfg.source} ${cfg.destination}";
          User = cfg.user;
          Group = cfg.group;
        };
      };
    }) config.services.copyFile;
  };
}