{ config, inputs, lib, ... }:
let
  selectModules = moduleSet: names: map (name: moduleSet.${name}) names;

  homeUsers = host:
    lib.genAttrs host.users (
      user:
      {
        imports =
          [ config.my.modules.homeManager.${user} ]
          ++ selectModules config.my.modules.homeManager host.homeFeatures
          ++ [ { home.homeDirectory = "/home/${user}"; } ];
      }
    );

  host = config.my.hosts."thinkstationpgx-2faa";
in
{
  systems = [ "aarch64-linux" ];

  flake.nixosConfigurations."thinkstationpgx-2faa" = inputs.nixpkgs.lib.nixosSystem {
    system = host.system;
    modules =
      selectModules config.my.modules.nixos host.features
      ++ selectModules config.my.modules.nixos host.users
      ++ [
        inputs.home-manager.nixosModules.home-manager
        {
          system.stateVersion = host.nixosStateVersion;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users = homeUsers host;
        }
      ];
  };

  # Compatibility output for the original standalone system-manager setup.
  flake.systemConfigs.default = inputs.system-manager.lib.makeSystemConfig {
    modules =
      selectModules config.my.modules.systemManager host.features
      ++ [ { nixpkgs.hostPlatform = host.system; } ];
  };
}
