{
  lib,
  config,
  pkgs,
  ...
}@args:
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.copyparty;
in
{
  options.plug.copyparty = {
    enable = lib.mkEnableOption "copyparty";
  };
  config = pluglib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.copyparty ];
    services.copyparty = {
      enable = true;
    };
  };
}
