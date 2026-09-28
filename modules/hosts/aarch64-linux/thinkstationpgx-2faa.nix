{ ... }:
{
  my.hosts."thinkstationpgx-2faa" = {
    system = "aarch64-linux";
    users = [ "ssi" ];
    features = [ "common" ];
    tags = [ "development" ];
  };
}
