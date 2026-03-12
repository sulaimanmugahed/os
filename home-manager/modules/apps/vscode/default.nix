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
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
    ms-dotnettools.vscode-dotnet-runtime
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
