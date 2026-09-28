{ lib, ... }:
{
  options.my.hosts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          system = lib.mkOption {
            type = lib.types.str;
            description = "The host system identifier, for example aarch64-linux.";
          };

          users = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Users configured on the host.";
          };

          features = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ "common" ];
            description = "System feature modules composed into the host.";
          };

          homeFeatures = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Home Manager feature modules composed for host users.";
          };

          tags = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Free-form metadata used to describe the host.";
          };

          nixosStateVersion = lib.mkOption {
            type = lib.types.str;
            default = "25.11";
            description = "NixOS state version for the host.";
          };
        };
      }
    );
    default = { };
    description = "Host metadata consumed by the host composition module.";
  };
}
