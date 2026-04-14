{ pkgs, osConfig, ...}: {
  home.packages = with pkgs.kdePackages; [
    kio
    kio-fuse
    kio-extras
    kdf
    qtsvg
    dolphin
    ffmpegthumbs
    plasma-workspace
    ark
  ];


  xdg.mimeApps.defaultApplications = {
    "application/x-shellscript" = [ "kitty.desktop" ];
  };
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ]; # Replace with your terminal's .desktop file
    };
  };

} // (if osConfig.services.desktopManager.plasma6.enable then [] else {
  xdg.configFile."menus/applications.menu".source =
    pkgs.kdePackages.plasma-workspace + "/etc/xdg/menus/plasma-applications.menu";
  xdg.configFile."kdeglobals".text =
    ''
      [General]
        TerminalApplication=${pkgs.kitty}/bin/kitty
    '';
})
