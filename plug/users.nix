{
  config,
  pkgs,
  lib,
  ...
}@args:
let
  cfg = config.plug.user;
  pluglib = import ./lib.nix args;
  inherit (lib) mkDefault;
in
{

  options.plug.user = lib.mkOption {
    type =
      with lib.types;
      (submodule {
        options = {
          enable = lib.mkEnableOption "user";
          name = lib.mkOption {
            type = lib.types.str;
          };
          shell = lib.mkOption {
            type = lib.types.package;
            default = pkgs.fish;
          };
          moreGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            example = [ "cool_group" ];
            description = "Extra extraGroups";
            default = [];
          };
          enableHomeManager = lib.mkOption {
            type = bool;
            default = true;
            description = "Enable home-manager for the user";
          };
        };
      });
    description = ''
      User definition for plug with fancy defaults.
    '';
  };

  config = lib.mkMerge [
    ((pluglib.mkIf config.plug.user.enable) 
     {
        users.users.${cfg.name} = {
          shell = cfg.shell;
          extraGroups = [
            "networkmanager"
            "wheel"
            "input"
          ] ++ cfg.moreGroups;
          description = "Main user of this pc";
          isNormalUser = true;
        };
      }
    )

    (pluglib.mkIf cfg.enableHomeManager {
      home-manager.users.${cfg.name} = import ./home-manager/home.nix;
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = mkDefault "back~";
    })
  ];
}
