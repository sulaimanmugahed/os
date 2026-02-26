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
  };

  programs.git = {
    enable = true;
    userName = constants.user.username;
    userEmail = constants.user.email;
    aliases = {
      pu = "push";
      cm = "commit";
    };
  };
}
