{
  flake,
  pkgs,
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
      fuzzel
      swww
      unstable.quickshell
      unstable.xwayland-satellite-unstable
      socat
      # For quickshell
      kdePackages.qtdeclarative
      wl-clipboard
    ];
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.enable = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.niri = {
        default = "gnome;gtk";
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.Notification" = "gtk";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };
    services.gnome.gnome-keyring.enable = true;
  };
}
