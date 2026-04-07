{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home.packages = with pkgs; [
    adwaita-qt
    adwaita-qt6
  ];

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
    platformTheme = "qtct";
  };
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
