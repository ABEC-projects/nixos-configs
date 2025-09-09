{ config, lib, pkgs, ... }@args:
let
  cfg = config.plug.intercept;
  pluglib = import ./lib.nix args;
in
{
  options.plug.intercept = {
    enable = lib.mkEnableOption "intercept service";
  };
  config = pluglib.mkIf cfg.enable {
    services.interception-tools = {
      enable = true;
      udevmonConfig = ''
       - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
         DEVICE:
           EVENTS:
             EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
       '';

    };
  };
}
