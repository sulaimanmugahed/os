{
  config,
  pkgs,
  lib,
  ...
}:

{
  home = {
    packages = with pkgs; [
      wireguard-tools
      protonvpn-gui
    ];
  };
}
