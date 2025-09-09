{
  description = "Pluggable modules for my nixOS config";
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:/thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
    copyparty.url = "github:9001/copyparty";
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      home-manager,
      stylix,
      nixpkgs,
      nix-alien,
      copyparty,
      niri,
      ...
    }:
    {
      nixosModules.default = {
        imports = [
          ./default.nix
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
      };
    };
}
