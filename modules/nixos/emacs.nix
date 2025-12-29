{ pkgs, ... }:
{
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = with pkgs;((emacsPackagesFor emacs).emacsWithPackages (
    epkgs: [ epkgs.vterm ]
  ));
  };
}
