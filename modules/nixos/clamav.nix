{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clamav
  ];
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  systemd.services.clamav-freshclam = {
    environment = {
      http_proxy = "socks5://127.0.0.1:1079";
      all_proxy = "socks5://127.0.0.1:1079";
    };
  };
  systemd.services.clamav-daemon = {
    enable = false;
    environment = {
      http_proxy = "socks5://127.0.0.1:1079";
      all_proxy = "socks5://127.0.0.1:1079";
    };
  };
}
