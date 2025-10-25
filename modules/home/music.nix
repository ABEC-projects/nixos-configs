{ pkgs, config, ... }:
{
  config = {
    services.playerctld.enable = true;
    services.mpd = {
      enable = true;
      musicDirectory = "/home/${config.me.username}/Music/external";
      extraConfig = ''
        auto_update "yes"
        replaygain "track"
        audio_output {
          type            "pulse"
          name            "default (pulse audio)"
          replay_gain_handler  "software"
        }
        audio_output {
          type            "fifo"
          name            "Visualizer feed"
          path            "/tmp/mpd.fifo"
          format          "44100:16:1"
        }

      '';
    };
    services.mpd-mpris.enable = true;
    home.packages = with pkgs; [
      mpd
      mpc
      ncmpcpp
      rmpc
      pms
    ];
  };
}
