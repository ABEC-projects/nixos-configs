{
  pkgs,
  config,
  lib,
  ...
}@inputs:
let
  cfg = config.plug.music;
  pluglib = import ./lib.nix inputs;
in
{
  options.plug.music = {
    enable = lib.mkEnableOption "music";
  };
  config = pluglib.mkIf cfg.enable {
    services.playerctld.enable = true;
    environment.systemPackages = with pkgs; [
      mpd
      mpc
      ncmpcpp
      rmpc
      pms
    ];
  };
}
