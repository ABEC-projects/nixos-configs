{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  imports = [
    ./sway.nix
    ./i3.nix
    ./yazi.nix
    ./niri.nix
    ./cursor.nix
  ];
    
  config = {
    home.packages = [ ];

    programs.tmux = {
      enable = true;
      shortcut = "s";
      baseIndex = 1;
      mouse = true;
      newSession = true;
      extraConfig = (builtins.readFile ./dotfiles/tmux/tmux.conf);
    };

    home.stateVersion = lib.mkDefault "25.05";
  };
}
