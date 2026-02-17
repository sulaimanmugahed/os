{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    pkgs.vscode-extensions.ms-dotnettools.csharp
    pkgs.vscode-extensions.ms-dotnettools.vscode-dotnet-runtime
    # pkgs.vscode-extensions.ms-dotnettools.csdevkit
  ];
}
