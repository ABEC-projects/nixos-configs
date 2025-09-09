{pkgs, config, lib, ...}@args:
let
  types = lib.types;
  pluglib = import ./lib.nix args;
in
{
  options = {
    plug.bluetooth.enable = lib.mkOption {
      type = types.bool;
      default = config.plug.machineType == "laptop";
    };
    plug.wifi.enable = lib.mkOption {
      type = types.bool;
      default = config.plug.machineType == "laptop";
    };
  };
  config = pluglib.mkIf config.plug.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    environment.systemPackages = with pkgs; [ 
      bluetui
    ];
  };
}
