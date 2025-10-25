{
  flake,
  pkgs,
  lib,
  ...
}:
let
  pictures = pkgs.fetchFromGitHub {
    owner = "ABEC-projects";
    repo = "pictures";
    rev = "6ba444abad827889a155cc13708fcfe11d870a38";
    sha256 = "sha256-bQ754HdeInB9mUD8kVzGK4T/sWvqFwQnBzFUAFoQgpg=";
  };
in
{
  imports = [
    flake.inputs.stylix.nixosModules.stylix
  ];

  config = {
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    stylix.image = pictures + /MikuDarkBg.jpg;
    stylix.polarity = "dark";
  };
}
