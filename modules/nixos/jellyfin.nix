{ flake, pkgs, ... }:
let
  unstable = (
    import flake.self.inputs.unstable {
      system = pkgs.system;
    });
in
  {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    unstable.jellyfin-desktop
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
