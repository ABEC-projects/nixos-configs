{
  perSystem =
    { pkgs, ... }:
    rec {
      packages.cpf = pkgs.writeShellApplication {
        name = "cpf";
        meta.description = "Copy given files as uri-list to clipboard";
        runtimeInputs = with pkgs; [
          xclip
          gnused
          wl-clipboard
        ];
        text = builtins.readFile ./cpf.sh;
      };
      apps.cpf = {
        type = "app";
        program = "${packages.cpf}/bin/cpf";
      };
    };
}
