# Nix flake containing various project templates.

{
  description = "A collection of flake templates";

  outputs =
    { nixpkgs, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${pkgs.stdenv.hostPlatform.system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ ];
      };

      templates = {
        dotnet = {
          path = "./dotnet";
          description = "Dotnet development template ";
        };
      };
    };
}
