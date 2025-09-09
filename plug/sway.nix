{ lib, config, pkgs, ... }@args:
let
  cfg = config.plug.sway;
  pluglib = import ./lib.nix args;
  inherit (lib) mkDefault;
in
{
  options.plug.sway = {
    enable = lib.mkEnableOption "sway";
  };

  config = pluglib.mkIf cfg.enable {
    programs.sway.enable = mkDefault true;
  };
}
