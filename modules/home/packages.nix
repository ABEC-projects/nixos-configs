{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [

    # Nix dev
    cachix
    nixd
    nil
    nix-info
    nixpkgs-fmt


    less
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
    # # Tmate terminal sharing.
    # tmate = {
    #   enable = true;
    #   #host = ""; #In case you wish to use a server other than tmate.io
    # };
  };
}
