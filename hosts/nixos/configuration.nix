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

  services.openssh.enable = true;

}
