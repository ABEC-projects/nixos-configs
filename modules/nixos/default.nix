# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, lib, pkgs, ... }:
{
  imports = [
    flake.inputs.self.nixosModules.common
  ];
  options = {
    battery_id = lib.mkOption {
      default = null;
      example = "BAT0";
      type =  with lib.types; uniq (nullOr str);
    };
  };

  config = {
    nixpkgs.config.allowUnfree = lib.mkForce true;
    services.openssh.enable = true;

    environment.systemPackages = with pkgs; [
      github-cli
      git
    ];
  };
}
