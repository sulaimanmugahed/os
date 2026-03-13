{
  config,
  pkgs,
  lib,
  ...
}:
let
  marketplace = pkgs.vscode-utils.buildVscodeMarketplaceExtension;
  defaultExtensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    (marketplace {
      mktplcRef = {
        publisher = "ms-dotnettools";
        name = "csharp";
        version = "2.123.34";
        sha256 = "sha256-RgJZq83YsL87R2oO6pEaQbVMghmnIBc+4BSZQa5RoTA=";
      };
    })
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
        name = "csdevkit";
        version = "2.13.9";
        sha256 = "sha256-JL8InnTTeRXHRTDioggGc6ePiDaI/elv/IV5vL1XCdI=";
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
        publisher = "cweijan";
        name = "vscode-postgresql-client2";
        version = "8.4.5";
        sha256 = "sha256-P7LI4m4GgJK+WltbgiKvleE/B4peuZhewOGrWDQoHMI=";
      };
    })

    streetsidesoftware.code-spell-checker
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
