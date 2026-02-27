{
  description = "Dotnet Dev-Shell";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/078d69f03934859a181e81ba987c2bb033eebfc5";
  };

  outputs =
    { nixpkgs
    , utils
    , ...
    }:

    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        dotnetPkg = with pkgs;
          (dotnetCorePackages.combinePackages [
            dotnetCorePackages.sdk_10_0-bin
            dotnetCorePackages.sdk_9_0-bin
          ]);

        deps = with pkgs;
          [
            zlib
            zlib.dev
            openssl
            dotnetPkg
          ];
      in
      {
        devShells.default = pkgs.mkShell {
          name = "dotnet";
          buildInputs = deps;
          shellHook = ''
            export DOTNET_ROOT="${dotnetPkg}/share/dotnet"
            export PATH="$DOTNET_ROOT/bin:$PATH"
          '';
        };
      }
    );
}
