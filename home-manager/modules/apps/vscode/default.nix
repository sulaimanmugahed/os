{ config, pkgs, lib, ... }:
let

  baseExtensions = with pkgs.vscode-extensions;[

  ];

  csharpExtensions = with pkgs.vscode-extensions;[
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
    ms-dotnettools.vscode-dotnet-runtime
  ];

  mkProfile = extra: {
    extensions = lib.unique (baseExtensions ++ extra);
  };

in
{
  programs.vscode = {
    enable = true;
    # mutableExtensionsDir = true;
    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
      } // mkProfile [ ];
      csharp = mkProfile csharpExtensions;
    };
  };
}
