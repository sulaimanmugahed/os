
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sulaiman = {
    isNormalUser = true;
    description = "Sulaiman Mugahed";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
vscode
(dotnetCorePackages.combinePackages [
dotnetCorePackages.sdk_10_0-bin
dotnetCorePackages.sdk_9_0-bin
])

pkgs.nodePackages_latest.nodejs
git
icu
zlib
#pkgs.jetbrains.rider
  ];
programs.vscode.extensions = with pkgs.vscode-extensions; [
ms-dotnettools.csharp
];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    pkgs.vscode-extensions.ms-dotnettools.csharp
  ];

  services.openssh.enable = true;


  system.stateVersion = "25.11"; # Did you read the comment?
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.oci-containers = {
  backend = "docker";
  containers = {
    postgresql = {
      autoStart = true;
      image = "postgres:16";
      ports=["5432:5432"];
      environment = {
          POSTGRES_USER= "postgres" ;
          POSTGRES_PASSWORD ="postgres";
       };
      volumes = [
            "/var/lib/postgres-data:/var/lib/postgresql/data"
       ];

    };
  pgadmin = {
    autoStart = true;
    image = "dpage/pgadmin4";
    ports = ["8085:80"];
      volumes = [
        "/var/lib/pgadmin-data:/var/lib/pgadmin"
      ];
      environment = {
        PGADMIN_DEFAULT_EMAIL = "admin@admin.com";
        PGADMIN_DEFAULT_PASSWORD = "password";
      };
    };
  };

 
  
};
}

