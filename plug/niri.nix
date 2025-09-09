{
  config,
  lib,
  pkgs,
  unstable,
  ...
}@args:
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.niri;
in
{
  options.plug.niri = {
    enable = lib.mkEnableOption "plug";
  };

  config = pluglib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      niri-unstable
      fuzzel
      xwayland-satellite-unstable
      swww
      unstable.quickshell
      socat
      kdePackages.qtdeclarative
    ];
    programs.niri.package = pkgs.niri;
    programs.niri.enable = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.niri = {
        default = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      };
    };
    services.gnome.gnome-keyring.enable = true;
  };
}
