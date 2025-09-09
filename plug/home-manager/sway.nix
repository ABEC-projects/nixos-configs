{ osConfig, pkgs, ...}@args:
let
  pluglib = import ./lib.nix args;
  _mod = "Mod4";
  _keyb = {
          "${_mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
          "${_mod}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun";
          "${_mod}+Mod1+r" = "reload";
          "${_mod}+Shift+e" =  "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";


          "${_mod}+Shift+q" = "kill";
          "${_mod}+F3" = "exec mpc volume '-1'";
          "${_mod}+F4" = "exec mpc volume '+1'";
          "${_mod}+F5" = "exec mpc prev";
          "${_mod}+F6" = "exec mpc toggle";
          "${_mod}+F7" = "exec mpc next";

          "${_mod}+h" = "focus left";
          "${_mod}+j" = "focus down";
          "${_mod}+k" = "focus up";
          "${_mod}+l" = "focus right";
          "${_mod}+Left" = "focus left";
          "${_mod}+Down" = "focus down";
          "${_mod}+Up" = "focus up";
          "${_mod}+Right" = "focus right";

          "${_mod}+Shift+h" = "move left";
          "${_mod}+Shift+j" = "move down";
          "${_mod}+Shift+k" = "move up";
          "${_mod}+Shift+l" = "move right";
          "${_mod}+Shift+Left" = "move left";
          "${_mod}+Shift+Down" = "move down";
          "${_mod}+Shift+Up" = "move up";
          "${_mod}+Shift+Right" = "move right";

          "${_mod}+Mod1+h" = "split h";
          "${_mod}+v" = "split v";
          "${_mod}+f" = "fullscreen toggle";
          "${_mod}+w" = "layout tabbed";
          "${_mod}+r" = "layout toggle spleet";

          "${_mod}+Shift+space" = "floating toggle";
          "${_mod}+colon" = "focus mode_toggle";
          "${_mod}+a" = "focus parent";
          "${_mod}+z" = "focus child";
          
          "${_mod}+Shift+r" = "resize";

          "${_mod}+1" = "workspace number 1";
          "${_mod}+2" = "workspace number 2";
          "${_mod}+3" = "workspace number 3";
          "${_mod}+4" = "workspace number 4";
          "${_mod}+5" = "workspace number 5";
          "${_mod}+6" = "workspace number 6";
          "${_mod}+7" = "workspace number 7";
          "${_mod}+8" = "workspace number 8";
          "${_mod}+9" = "workspace number 9";
          "${_mod}+0" = "workspace number 10";

          "${_mod}+Shift+1" = "move container to workspace number 1";
          "${_mod}+Shift+2" = "move container to workspace number 2";
          "${_mod}+Shift+3" = "move container to workspace number 3";
          "${_mod}+Shift+4" = "move container to workspace number 4";
          "${_mod}+Shift+5" = "move container to workspace number 5";
          "${_mod}+Shift+6" = "move container to workspace number 6";
          "${_mod}+Shift+7" = "move container to workspace number 7";
          "${_mod}+Shift+8" = "move container to workspace number 8";
          "${_mod}+Shift+9" = "move container to workspace number 9";
          "${_mod}+Shift+0" = "move container to workspace number 10";

        };
in
with (import ./sway-and-i3.nix {
  term = "${pkgs.kitty}/bin/kitty";
  launcher = "${pkgs.wofi}/bin/wofi --show drun";
}); 
{
  config = pluglib.mkIf osConfig.plug.sway.enable {
    home.packages = with pkgs; [
      swaybg
    ];
    wayland.windowManager.sway = {
      enable = true;
      config = {
        inherit modifier keybindings;
        input = {
          "*" = {
            xkb_layout = "us,ru";
            xkb_options = "grp:alt_shift_toggle";
            repeat_rate = "40";
            repeat_delay = "300";
          };
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            middle_emulation = "enabled";
            natural_scroll = "enabled";
          };
        };
      };
    };
    programs.swaylock.enable = true;
  };
}
