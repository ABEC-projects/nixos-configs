{
  imports = [
    ./niri.nix
  ];

  services.displayManager.ly = {
    enable = true;
    x11Support = false;
    settings = {
      animation = "gameoflife";
    };
  };
}
