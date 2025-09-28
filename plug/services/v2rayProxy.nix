{ lib, config, pkgs, ... }@args:
let
  pluglib = import ../lib.nix args;
  cfg = config.plug.v2tayProxy;
in
{
  options.plug.v2rayProxy = {
    enable = lib.mkEnableOption "v2rayProxy";
  };

  config = pluglib.mkIf cfg.enable {

    sops.secrets = {
      proxyConfig = {
        format = "json";
        sopsFile = ../sops/secrets/proxy-config.json;
        key = "";
      };
    };

    uesrs.users.proxyUser = {
      isSystemUser = true;
      description = "User for proxy";
    };

    systemd.services.v2rayProxy = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "v2ray proxy server";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        KillSignal = "SIGINT";
        ExecStart = "${pkgs.v2ray}/bin/v2ray run -c ${config.sops.secrets.proxyConfig.path}";
        User = "proxyUser";
      };
    };
  };
}
