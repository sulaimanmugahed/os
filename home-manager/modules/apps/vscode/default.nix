{ config, pkgs, lib, ... }:
let

  defaultExtensions = with pkgs.vscode-extensions;[
    jnoortheen.nix-ide
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
    ms-dotnettools.vscode-dotnet-runtime
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
