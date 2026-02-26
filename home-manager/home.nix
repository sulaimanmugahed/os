{ homeStateVersion
, user
, constants
, ...
}:

{
  imports = [
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  home.sessionVariables = { };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          inherit (constants.user) name email;
        };
        alias = {
          pu = "push";
          cm = "commit";
        };
      };
    };


  };


}
