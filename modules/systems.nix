{ config, inputs, lib, ... }:
let
  selectModules = moduleSet: names: map (name: moduleSet.${name}) names;

  mkSystemConfig = host:
    inputs.system-manager.lib.makeSystemConfig {
      modules =
        selectModules config.my.modules.systemManager host.features
        ++ [ { nixpkgs.hostPlatform = host.system; } ];
    };

  systemConfigs = lib.mapAttrs (_name: mkSystemConfig) config.my.hosts;
in
{
  systems = [ "aarch64-linux" ];

  # No `default` output: an unmatched hostname must fail instead of selecting
  # another host's configuration implicitly.
  flake.systemConfigs = systemConfigs;

  perSystem =
    { system, ... }:
    {
      # Expose the pinned System Manager CLI without wrapping its behavior.
      apps.default = {
        type = "app";
        program = "${inputs.system-manager.packages.${system}.default}/bin/system-manager";
      };
    };
}
