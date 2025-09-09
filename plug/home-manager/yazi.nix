{ osConfig, pkgs, ... }@args:
let
  pluglib = import ./lib.nix args;
  getScript = import ../getScript.nix args;
  cfg = osConfig.plug.yazi;
in
{
  config = pluglib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      keymap = {
        mgr.append_keymap = [
          {
            on = [
              "c"
              "C"
            ];
            run = ''
              shell --confirm '
              ${getScript "cpf"} "$@"
              '
            '';
            desc = "Copy files to clipboard";
          }
        ];
      };
      settings = {
        opener = {
          open_feh = [
            { run = ''${pkgs.feh}/bin/feh "$@" ''; orthan = true; desc = "Open image(s) in feh";}
          ];
          open_nomacs = [
            { run = ''${pkgs.nomacs}/bin/nomacs "$@" ''; orthan = true; desc = "Open image in nomacs";}
          ];
          magick = [
            { run = ''${getScript "magick_convert"} "$@"''; block = true; desc = "Convert images with magick"; }
          ];
        };
        open = {
          prepend_rules = [
          { mime = "image/gif"; use = [ "open_nomacs" "open_feh" "open"  "magick"]; }
          { mime = "image/*"; use = [ "open_feh" "open_nomacs" "open" "magick"]; }
          { name = "*.jfif"; use = [ "open_feh" "open_nomacs" "open" "magick"]; }
          { name = "*.jpg"; use = [ "open_feh" "open_nomacs" "open" "magick"]; }
          { name = "*.png"; use = [ "open_feh" "open_nomacs" "open" "magick"]; }
          { name = "*.jpeg"; use = [ "open_feh" "open_nomacs" "open" "magick"]; }
          ];
        };
      };
    };
  };
}
