{ pkgs, lib, appimageTools, fetchurl,  ... }: {
  plug = {
    enable = true;
    sway.enable = true;
    i3.enable = true;
    intercept.enable = true;
    stylix.enable = true;
    yazi.enable = true;
    swap.enable = true;
    machineType = "main_pc";
    copyparty.enable = true;
    niri.enable = true;
    user = {
      enable = true;
      name = "abec";
      enableHomeManager = true;
      moreGroups = [ "plugdev" ];
    };
  };

  home-manager.users.abec.programs.niri.settings.outputs = {
    "DP-2" = {
      focus-at-startup = true;
      mode.height = 1080;
      mode.width = 1920;
      mode.refresh = 180.;
      position.x = 0;
      position.y = 0;
    };
    "HDMI-1" = {
      mode.height = 1080;
      mode.width = 1920;
      mode.refresh = 74.973;
      position.x = 1920;
      position.y = 0;
    };
  };

  programs.fish.enable = true;

  users.groups.plugdev = {};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;

  boot.supportedFilesystems = [ "ntfs" "exFAT" ];

  networking.firewall.allowedTCPPortRanges = [
  { from = 1000; to = 10000; }
  ];
  networking.firewall.allowedTCPPorts = [
    53317
    25565
    34197
    804
  ];
  networking.firewall.allowedUDPPortRanges = [
  { from = 1000; to = 10000; }
  ];
  networking.firewall.allowedUDPPorts = [
    53317
    25565
    34197
    804
  ];

  nix.settings.allowed-users = [
    "abec"
    "root"
  ];

  environment.sessionVariables = {
    TERMINAL = "kitty";
    EDITOR = "nvim";
  };

  hardware.opentabletdriver.enable = true;
  programs.git.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     neovim
     less
     firefox
     tmux
     zsh
     ripgrep
     zoxide
     fzf
     elinks
     kitty
     libgcc
     zig
     rustup
     gcc
     go
     picom
     feh
     mpv
     ncmpcpp
     mpd
     mpc-cli
     keepassxc
     xfce.thunar
     yazi
     qpwgraph
     pavucontrol
     home-manager
     nomacs
     mprocs
     protontricks
     prismlauncher
     bacon
     qbittorrent
     lsof
     bat
     lsd
     python3
     wineWowPackages.waylandFull
     # (wine.override { wineBuild = "wine64"; })
     interception-tools
     interception-tools-plugins.caps2esc
     lua52Packages.lua
     lua52Packages.lua-lsp
     lua52Packages.luarocks
     # pkgs.luajitPackages.luarocks
     pkg-config
     alsa-lib
     alsa-lib.dev
     appimage-run
     earlyoom
     r2modman
     exfat
     tun2socks
     ventoy
     krita
     xdotool
     nil
     rusty-man
     libclang
     lutris
     tetrio-desktop
     gh
     libimobiledevice
     fd
     nodejs_22
     tree-sitter
     jq
     bacon
     yt-dlp
     localsend
     libreoffice
     maestral
     telegram-desktop
     syncthing
     obsidian
     speedcrunch
     lazygit
     prusa-slicer
     freecad
     # nix-alien-pkgs.nix-alien
     gamemode
     ldtk
     termscp
     telegram-desktop
     shotcut
     file
     freecad
     blender
     icu
     helix
     obs-studio
     obs-studio-plugins.wlrobs
     vesktop
     bluetui
     wofi
     waybar
     playerctl
     # mpdris2
     wl-clipboard
     hyprshot
     hyprpaper
     puddletag
     discord
     grim
     slurp
     ffmpeg
     nicotine-plus
     fish
     steamtinkerlaunch
     nushell
     godot_4
     bottles
     (import ./plug/packages/zed.nix {inherit lib appimageTools fetchurl;})
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];

  services = {
    playerctld.enable = true;

    interception-tools = {
      enable = true;
      udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };

    openssh = {
      enable = true;
      allowSFTP = true;
      banner = ''
        You are about to connect to my computer.
        Are you shure this is the place you wanna be?
      '';
      settings = {
        PasswordAuthentication =  false;
	KbdInteractiveAuthentication = false;
      };
    };
  };
  services.earlyoom.enable = true;
  systemd.services.factorio-custom = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "factorio server";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      KillSignal = "SIGINT";
      ExecStart = "/home/abec/.apps/factorio/start.sh";
      User = "abec";
    };
  };
  systemd.services.ss = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "shadowsocks vpn server";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      KillSignal = "SIGINT";
      ExecStart = "${pkgs.shadowsocks-rust}/bin/ssserver -v -c /home/abec/.config/ss/server-config.json";
    };
  };
  systemd.services.maestral = {
    enable = true;
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    description = "dropbox client";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      KillSignal = "SIGINT";
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      User = "abec";
    };
  };
  systemd.services.syncthing = {
    enable = true;
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    description = "syncthing daemon";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      KillSignal = "SIGINT";
      ExecStart = "${pkgs.syncthing}/bin/syncthing";
      User = "abec";
    };
  };
}
