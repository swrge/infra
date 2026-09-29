{ ... }:
let
  systemManager =
    {
      config,
      lib,
      ...
    }:
    {
      options.system-manager.podman.enable = lib.mkEnableOption "rootless Podman for ssi";

      config = lib.mkMerge [
        {
          users.users.ssi = {
            isNormalUser = true;
            group = "users";
            home = "/home/ssi";
          };
        }
        (lib.mkIf config.system-manager.podman.enable {
          users.users.ssi = {
            autoSubUidGidRange = true;
            linger = true;
          };
        })
      ];
    };
in
{
  config = {
    my.users.ssi = {
      description = "Primary user";
      # Preserve the identity from the original system-wide gitconfig.
      gitName = "swrge";
      gitEmail = "swrgingrage@gmail.com";
    };

    my.modules.systemManager.ssi = systemManager;
  };
}
