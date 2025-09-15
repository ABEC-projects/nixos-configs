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
      fuzzel
      swww
      unstable.quickshell
      unstable.xwayland-satellite-unstable
      socat
      kdePackages.qtdeclarative
    ];
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.enable = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
      config.niri = {
        default = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      };
    };
    services.gnome.gnome-keyring.enable = true;
  };
}
