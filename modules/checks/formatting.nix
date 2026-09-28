{ ... }:
let
  repository = ../../.;
in
{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-rfc-style;

      checks.formatting = pkgs.runCommand "check-formatting" {
        nativeBuildInputs = [ pkgs.nixfmt-rfc-style ];
      } ''
        cd ${repository}
        find . -type f -name '*.nix' -print0 | xargs -0 nixfmt --check
        touch $out
      '';
    };
}
