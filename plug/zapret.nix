{
  lib,
  config,
  pkgs,
  ...
}@args:
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.zapret;
  inherit (lib) mkDefault;
in
{
  options.plug.zapret = {
    enable = lib.mkEnableOption "zapret";
  };

  config = pluglib.mkIf cfg.enable {
    services.zapret = {
      enable = true;
      params = mkDefault [
        "--dpi-desync=fake --dpi-desync-fooling=badseq"
      ];
    };
    environment.systemPackages = [ pkgs.zapret ];
  };
}
