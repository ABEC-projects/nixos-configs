{
  home-manager,
  stylix,
  nix-alien,
  copyparty,
  niri,
  sops-nix,
}:
{
  imports = [
    ./plug.nix
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    copyparty.nixosModules.default
    niri.nixosModules.niri
    sops-nix.nixosModules.sops
    {
      environment.systemPackages = [
        nix-alien.packages.x86_64-linux.nix-alien
      ];
      nixpkgs.overlays = [
        copyparty.overlays.default
        niri.overlays.niri
      ];
      programs.nix-ld.enable = true;
    }
  ];
}
