{ lib, config, pkgs, ... }@args: 
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.i3;
in
{
  options.plug.i3 = {
    enable = lib.mkEnableOption "i3";
  };

  config = pluglib.mkIf cfg.enable {
    services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        xclip
        dunst
        rofi
        i3status
        i3lock
      ];
    };
    services.libinput.mouse.middleEmulation = false;
    plug.xserver.enable = true;
    environment.pathsToLink = [ "/libexec" ];
  };
}
