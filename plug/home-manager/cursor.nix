{ lib, osConfig, pkgs, ... }@args:
let
  pluglib = import ./lib.nix args;
in
{
  config = pluglib.mkIf (osConfig.plug.machineType != "server") {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      size = 24;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };
}
