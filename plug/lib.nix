{ lib, config, pkgs, ... }: rec {
  mkIf = cond: lib.mkIf (config.plug.enable && cond);
  getScript = name: "${scripts.${name}}/bin/${name}";
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
}
