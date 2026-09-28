{ config, ... }:
let
  user = config.my.users.ssi;

  homeManager = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = user.gitName;
          email = user.gitEmail;
        };
        init.defaultBranch = "main";
      };
    };
  };
in
{
  config = {
    my.modules.homeManager.git = homeManager;
    flake.homeManagerModules.git = homeManager;
  };
}
