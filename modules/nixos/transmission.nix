{ pkgs, lib, config, ...}: {
  options = {
    transmissionUsers = with lib; mkOption {
      type = types.listOf types.string;
      description = "List of users to have access to torrent files";
      default = [];
      defaultText = "[]";
      example = ''[ "user" ]'';
    };
  };

  config = {
    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
      openPeerPorts = true;
      openRPCPort = true;
      settings = {
        download-dir = "/mnt/Storage/Torrents";
        incomplete-dir = "/mnt/Storage/Torrents/.incomplete";
      };
    };

    environment.systemPackages = with pkgs; [
        transmission_4
        transmission-remote-gtk
        stig
    ];

    users.users = lib.mkMerge
      (map (user: {
        "${user}" = {
          extraGroups = [ config.services.transmission.group ];
        };
      }) config.transmissionUsers);
  };
}
