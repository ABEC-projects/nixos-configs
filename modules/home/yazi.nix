{ flake, pkgs, ... }@args:
let
  inherit (flake.inputs) self;
in
{
  config = {
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
              ${self.packages.${pkgs.system}.cpf} "$@"
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
            { run = ''${self.packages.${pkgs.system}.cpf} "$@"''; block = true; desc = "Convert images with magick"; }
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
