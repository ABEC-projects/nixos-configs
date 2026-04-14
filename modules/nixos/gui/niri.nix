{
  flake,
  pkgs,
  lib,
  ...
}:
let
  unstable = (
    import flake.self.inputs.unstable {
      system = pkgs.system;
      overlays = [flake.inputs.niri.overlays.niri];
    }
  );
in
{
  imports = [
    flake.inputs.niri.nixosModules.niri
  ];

  config = {
    nixpkgs.overlays = [
      flake.inputs.niri.overlays.niri
    ];
    environment.systemPackages = with pkgs; [
      unstable.quickshell
      unstable.xwayland-satellite-unstable
      socat
      # For quickshell
      unstable.kdePackages.qtdeclarative
      wl-clipboard
    ];
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.enable = true;
    services.gnome.gnome-keyring.enable = lib.mkForce false;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
      config.niri = {
        default = "kde;gtk;gnome";
        "org.freedesktop.impl.portal.FileChooser" = "kde";
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.Notification" = "gtk";
      };
    };
  };
}
