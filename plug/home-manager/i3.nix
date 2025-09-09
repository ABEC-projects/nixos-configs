{ lib, pkgs, osConfig, ...}@args:
let
  pluglib = import ./lib.nix args;
  cfg = osConfig.plug.i3;
in
{
  config = pluglib.mkIf cfg.enable 
  (with (import ./sway-and-i3.nix {term = "${pkgs.kitty}/bin/kitty"; launcher = "${pkgs.rofi}/bin/rofi -show drun";});
  {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        inherit keybindings modifier;
      };
    };
  });
}
