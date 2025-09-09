{ config, lib, pkgs, ...}@args:
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.yazi;
in
{
  options.plug.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = pluglib.mkIf cfg.enable { 
    environment.systemPackages = [ pkgs.yazi ];
  };
}
