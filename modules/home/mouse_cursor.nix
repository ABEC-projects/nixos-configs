{ pkgs, ... }:
{
  config = {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      size = 24;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };
}
