{ config, ... }:
let
  user = config.my.users.ssi;

  system =
    { lib, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bashInteractive
        git
        tldr
        ripgrep
        bat
      ];
      environment.etc."gitconfig".text = lib.generators.toGitINI {
        user = {
          name = user.gitName;
          email = user.gitEmail;
        };
        init.defaultBranch = "main";
      };
    };
in
{
  config = {
    my.modules.systemManager.common = system;
  };
}
