{
  config,
  lib,
  pkgs,
  ...
}@args:
let
  pluglib = import ./lib.nix args;
  cfg = config.plug.hibernation;
in
{
  options.plug.hibernation = {
    enable = lib.mkEnableOption "hibernation";
    resume_offset = lib.mkOption {
      type = lib.types.int;
      description = lib.literalMD ''
        phisical_offset from 'filefrag -v <swapfile> | head'.
        See [this](https://nixos.wiki/wiki/Hibernation) NixOS wiki page.
      '';
    };
    root_uuid = lib.mkOption {
      type = lib.types.str;
      description = "Uuid of root partition";
    };
  };

  config = pluglib.mkIf cfg.enable {

    assertions = [
      {
        assertion = cfg.root_uuid != null;
        message = "plug.hibernation.root_uuid should be set!";
      }
      {
        assertion = cfg.resume_offset != null;
        message = "plug.hibernation.resume_offset should be set!";
      }
    ];

    plug.swap.enable = true;

    boot.kernelParams = [
      "resume_offset=${builtins.toString cfg.resume_offset}"
      "mem_sleep_default=deep"
    ];
    boot.resumeDevice = "/dev/disk/by-uuid/${cfg.root_uuid}";

    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;

    services.logind.lidSwitch = "suspend-then-hibernate";
    # Hibernate on power button pressed
    services.logind.powerKey = "hibernate";
    services.logind.powerKeyLongPress = "poweroff";

    # Define time delay for hibernation
    systemd.sleep.extraConfig = ''
      HibernateDelaySec=30m
    '';
  };
}
