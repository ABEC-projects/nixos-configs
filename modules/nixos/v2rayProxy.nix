{ config, pkgs, ... }:
{
  config = {
    sops.secrets = {
      proxyConfig = {
        format = "binary";
        sopsFile = ./common/sops/secrets/proxy-config.json;
        owner = "proxyUser";
      };
    };

    users.users.proxyUser = {
      isSystemUser = true;
      description = "User for proxy";
      group = "proxyUser";
    };
    users.groups.proxyUser = {};

    systemd.services.v2rayProxy = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "v2ray proxy server";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        KillSignal = "SIGINT";
        ExecStart = "${pkgs.v2ray}/bin/v2ray run -format json -c ${config.sops.secrets.proxyConfig.path}";
        User = "proxyUser";
      };
    };
  };
}
