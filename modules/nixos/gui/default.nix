{config, ...}: {
  imports = [
    ./niri.nix
  ];

  services.displayManager.ly = {
    enable = true;
    x11Support = false;
    settings = {
      animation = "dur_file";
      dur_file_path = "${./blackhole.dur}";
      full_color = true;
      show_tty = true;
      bigclock = "en";
      inherit (config) battery_id;
    };
  };
}
