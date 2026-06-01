{ config, ... }:
{
  # https://nixos.asia/en/git
  programs = {
    gh.enable = true;
    git = {
      enable = true;
      ignores = [
        "*~"
        "*.swp"
      ];
      settings = {
        user = {
          email = config.me.email;
          name = config.me.fullname;
        };
      };
    };
    lazygit.enable = true;
  };

}
