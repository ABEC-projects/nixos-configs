{ lib, config, pkgs, ... }@args:
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.xserver;
  inherit (lib) mkDefault;
in
{
  options.plug.xserver = {
    enable = lib.mkEnableOption "xserver";
  };

  config = pluglib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      autoRepeatDelay = mkDefault 200;
      autoRepeatInterval = mkDefault 35;
      desktopManager = {
        xterm.enable = false;
      };
      xkb = {
        layout = "us, ru";
        variant = "";
      };
    };
    services.libinput = {
      enable = mkDefault true;
      touchpad = {
        naturalScrolling = mkDefault true;
        tapping = mkDefault true;
      };
    };
  };

}
