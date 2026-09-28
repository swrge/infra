{ ... }:
{
  my.hosts."thinkstationpgx-2faa" = {
    system = "aarch64-linux";
    users = [ "ssi" ];
    features = [ "common" ];
    homeFeatures = [
      "shell"
      "git"
    ];
    tags = [ "development" ];
    nixosStateVersion = "25.11";
  };
}
