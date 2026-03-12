{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  mySystem.hostInfo.enable = true;

  services.printing.enable = true;

  programs.firefox.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [

    pkgs.nodePackages_latest.nodejs
    pandoc
    pkgs.powershell
    telegram-desktop
    wireguard-tools
    protonvpn-gui
    #pkgs.jetbrains.rider
  ];

  services.openssh.enable = true;

}
