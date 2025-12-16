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

  home.packages = with pkgs; [
    self.inputs.zen-browser.packages."${system}".default
    kitty
    feh
    mpv
    ncmpcpp
    mpc
    keepassxc
    kdePackages.dolphin
    qpwgraph
    pavucontrol
    nomacs
    protontricks
    prismlauncher
    qbittorrent
    r2modman
    krita
    (import self.inputs.unstable {
      system = pkgs.system;
      config.allowUnfree = true;
    }).lutris
    tetrio-desktop
    gh
    libimobiledevice
    nodejs_latest
    jq
    yt-dlp
    localsend
    libreoffice
    telegram-desktop
    obsidian
    speedcrunch
    prusa-slicer
    freecad-wayland
    gamemode
    ldtk
    shotcut
    blender
    helix
    playerctl
    puddletag
    discord
    ffmpeg
    steamtinkerlaunch
    bottles
    anki
    jdk
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
