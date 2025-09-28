{
  description = "NixOS config for my computers";

  # It is also possible to "inherit" an input from another input. This is useful to minimize
  # flake dependencies. For example, the following sets the nixpkgs input of the top-level flake
  # to be equal to the nixpkgs input of the nixops input of the top-level flake:
  inputs = {
    nixpkgs.url = "github:/NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:/NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:/nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:/nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:/thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";

    copyparty.url = "github:9001/copyparty";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "unstable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      unstable,
      home-manager,
      stylix,
      nix-alien,
      copyparty,
      niri,
      sops-nix,
      ...
    }:
    {

      # Used with `nixos-rebuild --flake .#<hostname>`
      # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
      nixosConfigurations.hsh = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          unstable = import unstable {
            inherit system;
            overlays = [ niri.overlays.niri ];
          };
        };
        modules = [
          ((import ./plug/makeModule.nix) {
            inherit
              home-manager
              stylix
              nix-alien
              copyparty
              niri
              sops-nix
              ;
          })
          {
            networking.hostName = "hsh";
            system.stateVersion = "24.05";
          }
          ./hsh-config.nix
          ./hsh-hardware.nix
        ];
      };
    };
}
