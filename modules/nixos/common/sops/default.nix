{ flake, ... }:
{
  imports = [
      flake.inputs.sops-nix.nixosModules.sops
  ];
  config = {
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/var/lib/sops-nix/keys.txt";
  };
}
