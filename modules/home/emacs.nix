{ pkgs, ... }:
{
  services.emacs = {
    enable = true;
    package = with pkgs;((emacsPackagesFor emacs).emacsWithPackages (
    epkgs: [ epkgs.vterm ]
  ));
  };
}
