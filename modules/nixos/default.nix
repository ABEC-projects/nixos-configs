# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, lib, pkgs, ... }:
{
  imports = [
    flake.inputs.self.nixosModules.common
  ];

  nixpkgs.config.allowUnfree = lib.mkForce true;
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    github-cli
    git
  ];
}
