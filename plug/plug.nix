{
  lib,
  config,
  pkgs,
  ...
}@args:
{
  imports = [
    ./users.nix
    ./environment.nix
    ./wireless.nix
    ./terminal-apps.nix
    ./music.nix
    ./intercept.nix
    ./swap.nix
    ./locales.nix
    ./stylix.nix
    ./sway.nix
    ./zapret.nix
    ./i3.nix
    ./yazi.nix
    ./xserver.nix
    ./hibernation.nix
    ./copyparty.nix
    ./niri.nix
    ./sops/sops.nix
    ./services/v2rayProxy.nix
  ];

  options.plug.enable = lib.mkEnableOption "plug";

  config = lib.mkIf config.plug.enable {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.overlays = [
      (import ./packages/overlay.nix)
    ];
    nixpkgs.config.allowUnfree = true;
    environment.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };
}
