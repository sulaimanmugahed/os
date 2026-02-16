# NixOS modules aggregation.
{
  imports = [
    ./bootloader.nix
    ./host-info.nix
    ./networking.nix
    ./users.nix
  ];
}
