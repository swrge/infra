{ config, inputs, ... }:
let
  selectModules = moduleSet: names: map (name: moduleSet.${name}) names;
  host = config.my.hosts."thinkstationpgx-2faa";
  systemConfig = inputs.system-manager.lib.makeSystemConfig {
    modules =
      selectModules config.my.modules.systemManager host.features
      ++ [ { nixpkgs.hostPlatform = host.system; } ];
  };
in
{
  systems = [ "aarch64-linux" ];

  flake.systemConfigs = {
    default = systemConfig;
    "thinkstationpgx-2faa" = systemConfig;
  };
}
