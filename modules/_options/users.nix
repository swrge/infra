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
    description = "User metadata shared by system-manager modules.";
  };
}
