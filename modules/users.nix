{ pkgs, user, ... }:
{

  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "adbusers"
      ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };

  };

}
