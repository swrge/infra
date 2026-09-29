{ ... }:
let
  podmanModule =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.podman
        pkgs.fuse-overlayfs
        pkgs.passt
        pkgs.slirp4netns
      ];

      # The user module owns the account and lazily enables its rootless
      # permissions when this feature sets system-manager.podman.enable.
      system-manager.podman.enable = true;

      # Quadlet reads rootless units from this path for user systemd managers.
      # Actual *.container/*.pod/*.volume files can be added here once a
      # workload is chosen; the README is ignored by the Quadlet generator.
      environment.etc."containers/systemd/users/README".text = ''
        Rootless Podman Quadlet units for users belong in this directory.

        Prefer a UID-specific subdirectory when adding a unit, for example:
          users/<uid>/my-service.container
      '';
    };
in
{
  config.my.modules.systemManager.podman = podmanModule;
}
