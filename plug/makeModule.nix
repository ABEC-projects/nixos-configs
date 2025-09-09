{
  home-manager,
  stylix,
  nix-alien,
  copyparty,
  niri,
}:
{
  imports = [
    ./plug.nix
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    copyparty.nixosModules.default
    niri.nixosModules.niri
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
