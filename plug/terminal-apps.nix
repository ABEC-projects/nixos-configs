{ pkgs, lib, config, ...}@args:
let
  pluglib = import ./lib.nix args;
in
{
  options = {
  };
  config = lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [
      yazi
      lsd
      bat
      lazygit
      gdu
    ];
  }
  ];
}
