{ lib, pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-linux";

  environment.systemPackages = with pkgs; [
    tldr
  ];
  environment.etc."gitconfig".text = lib.generators.toGitINI {
    user = {
      name = "swrge";
      email = "swrgingrage@gmail.com";
    };
    init.defaultBranch = "main";
  };
}
