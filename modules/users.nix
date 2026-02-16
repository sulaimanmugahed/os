{ pkgs, user, ... }:
{



  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };

  };


}
