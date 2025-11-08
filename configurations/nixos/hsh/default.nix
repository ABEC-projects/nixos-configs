# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, pkgs, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs)
    self
    nix-alien
    copyparty
    ;
in
{
  imports = [
    ./hardware-configuration.nix
    self.nixosModules.gui

    self.nixosModules.default
    self.nixosModules.intercept
    self.nixosModules.stylix
    self.nixosModules.v2rayProxy
    self.nixosModules.ime
    self.nixosModules.fonts
    self.nixosModules.obs-studio-virtual-camera

    copyparty.nixosModules.default

    {
      nixpkgs.overlays = [
        copyparty.overlays.default
      ];
      environment.systemPackages = with pkgs; [
        nix-alien.packages.x86_64-linux.nix-alien
        neovim
        less
        ripgrep
        fd
        bat
        lsd
        lsof
        libgcc
        zig
        rustup
        lua54Packages.lua
        appimage-run
        exfat
        file
        bluetui
        nftables
        tree-sitter
        transmission_4
        transmission-remote-gtk
        stig
      ];

      home-manager.users = config.helpers.forEveryUser (_: {
        programs.niri.settings.outputs = {
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
      });

      users.users.abec = {
        extraGroups = ["wheel" config.services.transmission.group ];
      };

      users.defaultUserShell = pkgs.zsh;
      networking.networkmanager.enable = true;
      security.rtkit.enable = true;
      networking.hostName = "hsh";
      networking.firewall.allowedTCPPortRanges = [
        {
          from = 1000;
          to = 10000;
        }
      ];
      networking.firewall.allowedTCPPorts = [
        53317
        25565
        34197
        804
      ];
      networking.firewall.allowedUDPPortRanges = [
        {
          from = 1000;
          to = 10000;
        }
      ];
      networking.firewall.allowedUDPPorts = [
        53317
        25565
        34197
        804
      ];
      environment.sessionVariables = {
        EDITOR = "nvim";
      };

      hardware.opentabletdriver.enable = true;
      programs.steam.enable = true;
      programs.zsh.enable = true;
      programs.nix-ld.enable = true;
      services.earlyoom.enable = true;
      services.transmission = {
        enable = true;
        package = pkgs.transmission_4;
        openPeerPors = true;
        openRPCPorts = true;
        settings = {
          download-dir = "/mnt/Storage/Torrents";
          watch-dir-enabled = true;
          watch-dir = "/home/abec/Torrents/watchlist";
          incomplete-dir = "/mnt/Storage/Torrents/.incomplete";
        };
      };

      systemd.services.maestral =
        {
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
    }
  ];
}
