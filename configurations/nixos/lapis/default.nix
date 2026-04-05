# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, pkgs, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs)
    self
    nix-alien
    ;
in
{
  imports = [
    ./hardware-configuration.nix
    self.nixosModules.gui

    self.nixosModules.default
    self.nixosModules.intercept
    self.nixosModules.v2rayProxy
    self.nixosModules.ime
    self.nixosModules.fonts
    self.nixosModules.wireshark

    {
      boot.kernelPackages = pkgs.linuxPackages_6_18;

      services.desktopManager.plasma6.enable = true;

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
        gcc
        rustup
        lua54Packages.lua
        appimage-run
        exfat
        file
        bluetui
        nftables
        tree-sitter
        jq
        gh

        self.inputs.zen-browser.packages."${system}".default
        libreoffice
        obsidian
        telegram-desktop
        localsend
        qbittorrent
        pavucontrol
        keepassxc
        kitty
        cmake
        speedcrunch
        anki
      ];

      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = [ "abec" ];

      users.users.abec = {
        extraGroups = [ "wheel" ];
      };

      users.defaultUserShell = pkgs.zsh;
      programs.zsh.enable = true;
      networking.networkmanager.enable = true;
      security.rtkit.enable = true;
      networking.hostName = "lapis";
      environment.sessionVariables = {
        EDITOR = "nvim";
      };

      programs.nix-ld.enable = true;
      services.earlyoom.enable = true;
      services.udisks2.enable = true;

      system.stateVersion = "24.05";
    }
  ];
}
