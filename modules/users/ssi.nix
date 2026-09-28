{ config, ... }:
let
  user = config.my.users.ssi;

  nixos =
    { pkgs, ... }:
    {
      users.users.ssi = {
        isNormalUser = true;
        description = user.description;
        extraGroups = user.extraGroups;
        shell = pkgs.bash;
      };
    };

  homeManager = {
    home.username = "ssi";
    home.stateVersion = user.homeStateVersion;
  };
in
{
  config = {
    my.users.ssi = {
      description = "Primary user";
      homeStateVersion = "25.11";
      extraGroups = [ "wheel" ];
      # Preserve the identity from the original system-wide gitconfig.
      gitName = "swrge";
      gitEmail = "swrgingrage@gmail.com";
    };

    my.modules.nixos.ssi = nixos;
    my.modules.homeManager.ssi = homeManager;

    flake.nixosModules.ssi = nixos;
    flake.homeManagerModules.ssi = homeManager;
  };
}
