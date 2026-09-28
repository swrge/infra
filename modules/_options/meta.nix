{ lib, ... }:
let
  moduleSet = lib.types.attrsOf lib.types.deferredModule;
in
{
  options.my.meta = lib.mkOption {
    type = lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "infra";
        };

        description = lib.mkOption {
          type = lib.types.str;
          default = "Dendritic ThinkStation configuration";
        };
      };
    };
    default = { };
    description = "Metadata about this configuration repository.";
  };

  options.my.modules = lib.mkOption {
    type = lib.types.submodule {
      options = {
        nixos = lib.mkOption {
          type = moduleSet;
          default = { };
          description = "Reusable NixOS lower-level modules.";
        };

        homeManager = lib.mkOption {
          type = moduleSet;
          default = { };
          description = "Reusable Home Manager lower-level modules.";
        };

        systemManager = lib.mkOption {
          type = moduleSet;
          default = { };
          description = "Reusable standalone system-manager lower-level modules.";
        };
      };
    };
    default = { };
    description = "Lower-level modules published by top-level dendritic modules.";
  };

  config.my.meta = {
    name = "infra";
    description = "Dendritic ThinkStation configuration";
  };
}
