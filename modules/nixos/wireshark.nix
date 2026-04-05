{ pkgs, lib, config, ... }: {
  options = {
    transmissionUsers = with lib; mkOption {
      type = types.listOf types.str;
      description = "List of users to have access to wireshark";
      default = [ "abec" ];
      defaultText = "[]";
      example = ''[ "user" ]'';
    };
  };

  config = {
    programs.wireshark.enable = true;
    environment.systemPackages = with pkgs; [
      wireshark
    ];
    users.users = lib.mkMerge
      (map (user: {
        "${user}" = {
          extraGroups = [ "wireshark" ];
        };
      }) config.transmissionUsers);
  };
}
