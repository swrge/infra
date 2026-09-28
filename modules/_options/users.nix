{ lib, ... }:
{
  options.my.users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          description = lib.mkOption {
            type = lib.types.str;
            default = "";
          };

          homeStateVersion = lib.mkOption {
            type = lib.types.str;
            default = "25.11";
          };

          extraGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
          };

          gitName = lib.mkOption {
            type = lib.types.str;
            default = "";
          };

          gitEmail = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
        };
      }
    );
    default = { };
    description = "User metadata shared by system and Home Manager modules.";
  };
}
