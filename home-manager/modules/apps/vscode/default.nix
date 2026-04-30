{
  config,
  pkgs,
  lib,
  ...
}:
let
  marketplace = pkgs.vscode-utils.buildVscodeMarketplaceExtension;
  defaultExtensions = with pkgs.vscode-extensions; [
    streetsidesoftware.code-spell-checker
    esbenp.prettier-vscode

    #nix
    jnoortheen.nix-ide

    #dotnet

    # (marketplace {
    #   mktplcRef = {
    #     publisher = "ms-dotnettools";
    #     name = "csharp";
    #     version = "2.120.3";
    #     sha256 = "sha256-RgJZq83YsL87R2oO6pEaQbVMghmnIBc+4BSZQa5RoTA=";
    #   };
    # })
    # (marketplace {
    #   mktplcRef = {
    #     publisher = "ms-dotnettools";
    #     name = "csdevkit";
    #     version = "2.10.3";
    #     sha256 = "sha256-JL8InnTTeRXHRTDioggGc6ePiDaI/elv/IV5vL1XCdI=";
    #   };
    #})
    (marketplace {
      mktplcRef = {
        publisher = "kreativ-software";
        name = "csharpextensions";
        version = "1.7.3";
        sha256 = "sha256-qv2BbcT07cogjlLVFOKj0masRRU28krbQ5LWcFrcgQw=";
      };
    })
    (marketplace {
      mktplcRef = {
        publisher = "ms-dotnettools";
        name = "vscode-dotnet-runtime";
        version = "3.0.0";
        sha256 = "sha256-RA7skgj6yFZxk2XuJZtcDrI4dFrAbwODmwqSx4xWFUY=";
      };
    })

    (marketplace {
      mktplcRef = {
        publisher = "patcx";
        name = "vscode-nuget-gallery";
        version = "1.2.5";
        sha256 = "sha256-OU50blk8G1sjtzf7RjiUpkD2LDJi2aY5Iz0TRrbg1gE=";
      };
    })

    denoland.vscode-deno

    #databases
    (marketplace {
      mktplcRef = {
        publisher = "cweijan";
        name = "vscode-postgresql-client2";
        version = "8.4.5";
        sha256 = "sha256-P7LI4m4GgJK+WltbgiKvleE/B4peuZhewOGrWDQoHMI=";
      };
    })

    #react

    (marketplace {
      mktplcRef = {
        publisher = "expo";
        name = "vscode-expo-tools";
        version = "1.6.2";
        sha256 = "sha256-Rs4mMhJ514ruId6zrJ2CFzGCXIemZpVJoA40gy41uYg=";
      };
    })

    (marketplace {
      mktplcRef = {
        publisher = "msjsdiag";
        name = "vscode-react-native";
        version = "1.13.0";
        sha256 = "sha256-zryzoO9sb1+Kszwup5EhnN/YDmAPz7TOQW9I/K28Fmg=";
      };
    })

    (marketplace {
      mktplcRef = {
        publisher = "dsznajder";
        name = "es7-react-js-snippets";
        version = "4.4.3";
        sha256 = "sha256-QF950JhvVIathAygva3wwUOzBLjBm7HE3Sgcp7f20Pc=";
      };
    })

    (marketplace {
      mktplcRef = {
        publisher = "gluestack";
        name = "gluestack-vscode";
        version = "0.1.22";
        sha256 = "sha256-KrnsRUB50W6cPFuk/ZprnfA5NhSKu9kQ5LtSqA9G2E8=";
      };
    })

    bradlc.vscode-tailwindcss

    #yaml
    redhat.vscode-yaml

  ];

  mkProfile = exts: {
    extensions = exts;
  };

in
{
  imports = [
    ./activation.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    mutableExtensionsDir = true;
    profiles = {
      default = mkProfile defaultExtensions;
    };
  };
}
