{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules
    ];

  mySystem.hostInfo.enable = true;

  services.printing.enable = true;

  programs.firefox.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [

    pkgs.nodePackages_latest.nodejs
    git
    pandoc
    pkgs.powershell
    telegram-desktop
    nixd
    nixpkgs-fmt
    wireguard-tools
    protonvpn-gui
    #pkgs.jetbrains.rider
  ];


  services.openssh.enable = true;

}

