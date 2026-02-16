{ lib, pkgs, ... }:
{
  imports = [
  ];
  users.users.sulaiman = {
    isNormalUser = true;
    description = "Sulaiman Mugahed";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

}
