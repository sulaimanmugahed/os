{
  description = "My Root OS flake";

  inputs = {
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/078d69f03934859a181e81ba987c2bb033eebfc5";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,

      # , nixpkgs-unstable
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.11";
      user = "sulaiman";

      hosts = [
        {
          hostname = "nixos";
          stateVersion = "25.11";
        }
      ];

      pkgConfig = {
        allowUnfree = true;
        allowBroken = false;
        allowInsecure = false;
        allowUnsupportedSystem = false;
      };

      constants = import ./shared/constants.nix;

      pkgs = (
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        }
      );
      # pkgs-unstable = (
      #   import nixpkgs-unstable {
      #     inherit system;
      #     config = {
      #       allowUnfree = true;
      #     };
      #   }
      # );

      makeSystem =
        { hostname, stateVersion }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              stateVersion
              hostname
              user
              pkgs
              pkgConfig
              constants
              ;
          };
          modules = [ ./hosts/${hostname}/configuration.nix ];
        };

    in
    {
      nixosConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs // { "${host.hostname}" = makeSystem { inherit (host) hostname stateVersion; }; }
      ) { } hosts;

      homeConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs
        // {
          "${user}@${host.hostname}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit
                inputs
                homeStateVersion
                user
                constants
                ;
              inherit (host) hostname;
            };
            modules = [
              ./home-manager/home.nix
            ];
          };
        }
      ) { } hosts;

    };
}
