{
  description = "A Node.js development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # <- change me to the latest version (new version released in May and November)
  };

  outputs =
    inputs:

    let
      overlays = [
        (self: super: {
          nodejs = super.nodejs_24; # <- choose Node.js version
        })
      ];

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system overlays; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              nodejs
              nodePackages.pnpm
            ];
          };
        }
      );
    };
}
