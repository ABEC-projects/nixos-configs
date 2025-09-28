{ pkgs, config, lib, ... }@args:
let
  pluglib = import ../lib.nix args;
in
{
  config = pluglib.mkIf true {
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${config.plug.user.name}/.config/sops/age/keys.txt";
  };
}
