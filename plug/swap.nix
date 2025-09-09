{ lib, config, pkgs, ... }@args:
let
  cfg = config.plug.swap;
  pluglib = import ./lib.nix args;
in
{
  options.plug.swap = {
    enable = lib.mkEnableOption "swap";
    size = lib.mkOption {
      type = lib.types.int;
      description = "Size of swap file in MB";
      default = 16 * 1024;
    };
  };

  config = pluglib.mkIf cfg.enable {
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = cfg.size;
      }
    ];
  };
}
