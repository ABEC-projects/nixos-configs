{pkgs, ...}: name: 
let
  scripts = {
    magick_convert = pkgs.writeShellApplication {
      name = "magick_convert";
      runtimeInputs = [
        pkgs.imagemagick
      ];
      text = builtins.readFile ./assets/scripts/magick_convert;
    };
    cpf = pkgs.writeShellApplication {
      name = "cpf";
      runtimeInputs = with pkgs; [
        xclip
        gnused
      ];
      text = builtins.readFile ./assets/scripts/cpf;
    };
  };
in
"${scripts.${name}}/bin/${name}"
