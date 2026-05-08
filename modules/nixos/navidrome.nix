{pkgs, lib, ...}:
{
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      Address = "0.0.0.0";
      EnableInsightsCollector = true;
      MusicFolder = "/mnt/Compressed/Music/Jellyfin";
      Jukebox = {
        Enabled = true;
        Default = "jack";
        Devices = [
          ["jack"  "pipewire/alsa_output.pci-0000_30_00.6.analog-stereo" ]
          ["dac" "pipewire/alsa_output.usb-FiiO_FiiO_BTR5-00.analog-stereo" ]
        ];
      };
      MPVPath = lib.getExe pkgs.mpv;
    };
  };
}
