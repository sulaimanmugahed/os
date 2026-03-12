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
        version = "2.120.3";
        sha256 = "sha256-dRNmjuV2lwa9Xe0M4LDOvCW80gVA1NcZHNeo7E4rqMo=";
      };
    })
    (marketplace {
      mktplcRef = {
        publisher = "ms-dotnettools";
        name = "csdevkit";
        version = "2.10.3";
        sha256 = "sha256-8oxIWjOCee5nxlJZZ58TZqNxZUrGltQnqr0L4u7LMNY=";
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
