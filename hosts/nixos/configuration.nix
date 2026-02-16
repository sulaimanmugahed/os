{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules
    ];

  mySystem.hostInfo.enable = true;


  # Set your time zone.
  time.timeZone = "Asia/Aden";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_YE.UTF-8";
    LC_IDENTIFICATION = "ar_YE.UTF-8";
    LC_MEASUREMENT = "ar_YE.UTF-8";
    LC_MONETARY = "ar_YE.UTF-8";
    LC_NAME = "ar_YE.UTF-8";
    LC_NUMERIC = "ar_YE.UTF-8";
    LC_PAPER = "ar_YE.UTF-8";
    LC_TELEPHONE = "ar_YE.UTF-8";
    LC_TIME = "ar_YE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  programs.firefox.enable = true;


  environment.systemPackages = with pkgs; [

    vscode
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_10_0-bin
      dotnetCorePackages.sdk_9_0-bin
    ])

    pkgs.nodePackages_latest.nodejs
    git
    pandoc
    pkgs.powershell
    telegram-desktop
    nixd
    nixpkgs-fmt
    #pkgs.jetbrains.rider
  ];



  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    pkgs.vscode-extensions.ms-dotnettools.csharp
    pkgs.vscode-extensions.ms-dotnettools.vscode-dotnet-runtime
    # pkgs.vscode-extensions.ms-dotnettools.csdevkit

  ];

  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  nix.settings.experimental-features = [ "nix-command" ];

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      postgres = {
        autoStart = true;
        image = "postgres:16";
        ports = [ "5432:5432" ];
        environment = {
          POSTGRES_USER = "postgres";
          POSTGRES_PASSWORD = "postgres";
        };
        volumes = [
          "/var/lib/postgres-data:/var/lib/postgresql/data"
        ];

      };
    };

  };
}

