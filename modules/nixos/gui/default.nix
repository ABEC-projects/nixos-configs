{
  imports = [
    ./niri.nix
  ];

  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
}
