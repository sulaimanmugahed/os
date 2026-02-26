{ lib, ... }:
with lib;
{
  imports = [
  ];

  networking = {
    networkmanager.enable = true;
    firewall.checkReversePath = false;
  };
}
