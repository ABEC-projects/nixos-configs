{lib, osConfig, ...}:
{
  mkIf = cond: lib.mkIf (cond && osConfig.plug.enable && osConfig.plug.user.enableHomeManager);
}
