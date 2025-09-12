{
  config,
  pkgs,
  lib,
  ...
}@inputs:
let
  pluglib = import ./lib.nix inputs;
  guiApps = with pkgs; [
    obsidian
    libreoffice
    kitty
    feh
    keepassxc
    pavucontrol
    gtk4
    gtk3
    gtk2
    gcolor3
  ];
in
{
  options.plug.machineType = lib.mkOption {
    type =
      with lib.types;
      (unique { message = "Only one machineType can be selected"; } (
        nullOr (enum [
          "main_pc"
          "laptop"
          "server"
        ])
      ));
    default = null;
    description = ''
      Defines which options to enable by default.
    '';
  };

  config = lib.mkMerge [
    {
      environment.variables = {
        EDITOR = "nvim";
        TERMINAL = "kitty";
      };
      environment.systemPackages = with pkgs; [
        cachix
      ];
    }
    (pluglib.mkIf config.plug.enable {
      environment.systemPackages = with pkgs; [
        fd
        ripgrep
        gh
        neovim
        helix
        fish
        maestral
        tmux
        bashmount
        sqlite
        yazi
        maestral
        lsd
        bluetui
        pavucontrol
        zig
        nixd
        nixfmt-rfc-style
        sshfs
      ];
    })
    (pluglib.mkIf (config.plug.machineType != "server") {
      environment.systemPackages =
        builtins.concatLists [
          guiApps
        ];
      environment.sessionVariables = {
        TERM = "kitty";
        EDITOR = "nvim";
        XMODIFIERS="@im=fcitx";
        XMODIFIER="@im=fcitx";
        GTK_IM_MODULE="fcitx";
        QT_IM_MODULE="fcitx";
      };
      fonts.packages = with pkgs; [
        nerd-fonts.bitstream-vera-sans-mono
        ipafont
      ];

      # Japanize
      i18n.inputMethod.type = "fcitx5";
      i18n.inputMethod.enable = true;

    })
  ];
}
