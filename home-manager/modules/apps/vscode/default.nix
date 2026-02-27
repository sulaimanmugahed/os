{ config, pkgs, lib, ... }:
let

  baseExtensions = with pkgs.vscode-extensions;[
    jnoortheen.nix-ide
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
  imports = [

  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    mutableExtensionsDir = true;
    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
      } // mkProfile [ ];
      csharp = mkProfile csharpExtensions;
    };
  };
}
