{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
  ];

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "abec";
    fullname = "ABEC-projects";
    email = "70073993+ABEC-projects@users.noreply.github.com";
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  home.packages = [
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
     wlrobs
    ];
  };

  services.syncthing.enable = true;

  home.stateVersion = "24.11";
}
