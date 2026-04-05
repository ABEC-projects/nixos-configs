{ pkgs, ... }: {
  systemd.user.services.maestral = {
    Unit = {
      Desctiption = "dropbox client";
      Enable = true;
    };
    Service = {
      Type = "simple";
      KillSignal = "SIGINT";
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
      After = [ "network.target" ];
    };
  };
}
