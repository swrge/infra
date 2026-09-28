{ ... }:
let
  homeManager = {
    programs.bash.enable = true;
  };
in
{
  config = {
    my.modules.homeManager.shell = homeManager;
    flake.homeManagerModules.shell = homeManager;
  };
}
